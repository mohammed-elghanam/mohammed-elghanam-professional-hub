# Google Play Data Safety Draft

Prepared from the current Android/Flutter application behavior on 12 August 2026.

> Important: this is a Play Console entry draft based on the current source code and known app architecture. Re-check it whenever SDKs, analytics, ads, authentication, forms, cloud services, or permissions are added.

## App behavior reviewed

The current app:

- does not require account creation or sign-in;
- does not include advertising SDKs;
- does not include analytics or behavioral tracking SDKs in the app code reviewed;
- does not contain user-input forms for collecting profile or account information;
- loads recognition-gallery images from `https://mohammed-elghanam-professional-hub.vercel.app`;
- opens email, phone, LinkedIn and website actions in external apps;
- contains PDF documents locally and lets the user save or share them by explicit action;
- uses Internet access for online gallery content and external web resources.

## Recommended Play Console answers

### Does your app collect or share any of the required user data types?

**Recommended starting answer: No**, for data intentionally collected by the application/developer.

Rationale: the reviewed app does not implement account registration, analytics, advertising, telemetry forms, or a developer-operated user database.

### Important infrastructure note

The online gallery is delivered by web-hosting infrastructure. Normal HTTPS requests can expose standard network metadata such as IP address and request headers to hosting infrastructure as part of content delivery and security logging. Before final submission, confirm the current Google Play Data Safety interpretation for transient/service-provider network processing and the actual hosting-provider configuration. If Play requires declaration of this processing for the deployed configuration, update the form accordingly.

### Is all user data collected by your app encrypted in transit?

If the form asks this after any data type is declared, the app's online content URLs use HTTPS. External actions are handed to external applications and are then governed by those services.

### Do you provide a way for users to request deletion of their data?

The app does not provide user accounts and does not intentionally maintain a developer database of user personal data. If Play presents an account-deletion question, answer that the app does not support account creation.

## Data types not intentionally collected by the app

Based on the reviewed source, do not declare intentional collection by the app for:

- Name or user profile information
- User email address submitted to the app
- Phone number submitted to the app
- Precise or approximate location
- Contacts
- SMS or call logs
- Photos or videos from the user's device
- Audio recordings
- Files uploaded to the developer
- Health data
- Financial information
- App activity for analytics or advertising
- Web browsing history
- Advertising ID for ads or profiling

## External-service caveat

The user can explicitly launch:

- email client;
- telephone dialer;
- LinkedIn;
- the Professional Hub website.

Once the user leaves the app, those third-party or system applications operate under their own privacy policies and settings. The Professional Hub does not receive the resulting external-service data merely because the link was opened.

## PDF handling

PDFs are bundled with the app. The user may explicitly save or share a copy. The current app code does not upload those PDF files to a developer-operated backend.

## Permissions / capabilities to keep under review

Current release workflow explicitly ensures Internet access. If future versions add camera, microphone, contacts, location, notifications with identifiers, authentication, crash analytics, cloud uploads, payments, ads, or third-party telemetry, this Data Safety declaration must be updated before release.

## Final pre-submit verification checklist

- Review final AAB dependencies and Android manifest.
- Confirm no SDK added analytics/telemetry behavior not visible in the top-level Dart source.
- Confirm hosting-provider logs and processing relevant to Play's definition of collection/sharing.
- Keep Privacy Policy wording consistent with the final Data Safety answers.
- Recheck this file for every future Play release.
