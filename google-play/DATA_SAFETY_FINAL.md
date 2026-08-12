# Google Play Data Safety — Final Conservative Declaration

Prepared for `com.mohammedelghanam.mohammed_elghanam_professional_hub` version `4.0.0+8`.

## Recommended Play Console answers

### Does your app collect or share any of the required user data types?

**Yes — conservative declaration.**

Reason: the Recognition Gallery retrieves HTTPS assets from the Professional Hub hosted on Vercel. A network request necessarily reaches the hosting provider, and Vercel documents that request events can include a public IP address and that IP addresses are still collected for business purposes such as DDoS mitigation. Google Play requires developers to disclose off-device collection according to actual use and specifically notes that IP-address handling must be evaluated according to its use.

### Data type

**Device or other IDs**

This is the conservative classification for request-level network identifiers associated with a device/browser connection. If Google Play Console later presents a more precise classification for the actual hosting behavior, use the more precise option.

### Is this data collected?

**Yes**

### Is this data shared?

**No**

Rationale: Vercel is being used as the hosting/service provider for the Professional Hub content, not as an advertising or data-broker partner. Google Play guidance generally does not treat transfers to a service provider processing data on the developer's behalf as "sharing" for the Data Safety section.

### Is collection required or optional?

**Required for the online Recognition Gallery / network content request.**

The app itself can be opened without an account, but fetching the online gallery requires a network request.

### Purpose

Select:

- **Fraud prevention, security, and compliance**
- If Play Console requires a second purpose for the technical delivery path, select **App functionality** only if needed to reflect delivery of the requested gallery content.

Do **not** select Advertising or marketing, Personalization, or Account management.

### Is data processed ephemerally?

**Do not claim ephemeral processing for the complete hosting path.**

Vercel documents request/observability events and retention windows, so the safest declaration is to treat the technical request data as collected rather than relying on the ephemeral-processing exemption.

### Is data encrypted in transit?

**Yes.**

The app requests the online gallery over HTTPS.

### Can users request deletion?

The app has no user accounts and does not intentionally maintain a user-profile database. Do not claim an account-deletion mechanism. Answer the Play Console deletion questions according to the exact options shown for an app without account creation.

## App-level data review

Current app behavior intentionally includes:

- No account creation or sign-in.
- No advertising SDK.
- No analytics SDK intentionally integrated in the Flutter application.
- No user-entered forms.
- No location permission.
- No contacts permission.
- No camera permission.
- No microphone permission.
- No SMS or call-log permission.
- Local PDF viewing.
- User-initiated PDF save/share actions.
- User-initiated external email, telephone, LinkedIn and website actions.
- HTTPS loading of Recognition Gallery images.

## Consistency requirement

Keep this declaration consistent with `privacy-policy.html`. If the hosting architecture changes, the gallery becomes fully offline, analytics is added, or another SDK is introduced, revisit Data Safety before the next Play release.
