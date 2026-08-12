from __future__ import annotations

import base64
import re
from io import BytesIO
from pathlib import Path

from PIL import Image, ImageDraw

NAVY = (3, 16, 29, 255)
NAVY_2 = (7, 29, 47, 255)
GOLD = (242, 182, 66, 255)
GOLD_2 = (255, 215, 117, 255)


def load_original_portrait() -> Image.Image:
    source = Path('lib/portrait_data_v2.dart').read_text(encoding='utf-8')
    match = re.search(r"kPortraitJpegBase64V2\s*=\s*'''(.*?)'''", source, flags=re.S)
    if not match:
        raise SystemExit('Unable to locate kPortraitJpegBase64V2')
    payload = re.sub(r'\s+', '', match.group(1))
    return Image.open(BytesIO(base64.b64decode(payload))).convert('RGBA')


def cover_crop(image: Image.Image, width: int, height: int, y_bias: float = 0.22) -> Image.Image:
    scale = max(width / image.width, height / image.height)
    resized = image.resize((round(image.width * scale), round(image.height * scale)), Image.Resampling.LANCZOS)
    left = max(0, (resized.width - width) // 2)
    extra_y = max(0, resized.height - height)
    top = min(extra_y, max(0, round(extra_y * y_bias)))
    return resized.crop((left, top, left + width, top + height))


def build_master_icon(portrait: Image.Image) -> Image.Image:
    size = 1024
    canvas = Image.new('RGBA', (size, size), NAVY)
    d = ImageDraw.Draw(canvas)
    d.rounded_rectangle((20, 20, 1004, 1004), radius=220, fill=NAVY)
    d.rounded_rectangle((40, 40, 984, 984), radius=205, outline=(255, 215, 117, 85), width=4)

    for y in (290, 400, 624, 734):
        d.line((54, y, 132, y), fill=GOLD, width=7)
        d.ellipse((43, y - 11, 65, y + 11), outline=GOLD_2, width=5)
        d.line((892, y, 970, y), fill=GOLD, width=7)
        d.ellipse((959, y - 11, 981, y + 11), outline=GOLD_2, width=5)

    portrait_box = (142, 100, 882, 892)
    pw = portrait_box[2] - portrait_box[0]
    ph = portrait_box[3] - portrait_box[1]
    portrait_crop = cover_crop(portrait, pw, ph)

    mask = Image.new('L', (pw, ph), 0)
    md = ImageDraw.Draw(mask)
    md.rounded_rectangle((0, 0, pw - 1, ph - 1), radius=245, fill=255)
    canvas.paste(portrait_crop, portrait_box[:2], mask)

    d = ImageDraw.Draw(canvas)
    d.rounded_rectangle((portrait_box[0] - 15, portrait_box[1] - 15, portrait_box[2] + 15, portrait_box[3] + 15), radius=260, outline=GOLD, width=18)
    d.rounded_rectangle((portrait_box[0] - 29, portrait_box[1] - 29, portrait_box[2] + 29, portrait_box[3] + 29), radius=270, outline=GOLD_2, width=4)

    badge = (394, 828, 630, 965)
    d.rounded_rectangle(badge, radius=54, fill=NAVY_2, outline=GOLD, width=7)
    d.line((443, 892, 481, 930, 512, 870, 543, 930, 581, 892), fill=GOLD_2, width=15, joint='curve')
    return canvas


def main() -> None:
    portrait = load_original_portrait()
    master = build_master_icon(portrait)

    # Google Play requires a 512x512 32-bit PNG with an alpha channel.
    # Keep RGBA even though the artwork itself is visually opaque.
    store_icon = Path('../Mohammed_Elghanam_Professional_Hub_Play_Icon_512.png')
    master.resize((512, 512), Image.Resampling.LANCZOS).convert('RGBA').save(store_icon, 'PNG', optimize=True)

    densities = {
        'mipmap-mdpi': 48,
        'mipmap-hdpi': 72,
        'mipmap-xhdpi': 96,
        'mipmap-xxhdpi': 144,
        'mipmap-xxxhdpi': 192,
    }
    for folder, px in densities.items():
        target = Path('android/app/src/main/res') / folder / 'ic_launcher.png'
        target.parent.mkdir(parents=True, exist_ok=True)
        master.resize((px, px), Image.Resampling.LANCZOS).convert('RGB').save(target, 'PNG', optimize=True)

    print(f'Generated Google Play icon: {store_icon}')
    print('Google Play icon mode: RGBA (32-bit PNG with alpha channel)')
    for folder, px in densities.items():
        print(f'{folder}/ic_launcher.png: {px}x{px}')


if __name__ == '__main__':
    main()
