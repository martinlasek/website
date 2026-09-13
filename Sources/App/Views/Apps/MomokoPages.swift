import HtmlVaporSupport

struct MomokoPages {
    static let all: [AppInfoPage] = [privacy, terms, support]

    static let privacy = AppInfoPage(
        appName: "Momoko", appSlug: "momoko", slug: "privacy-policy", title: "Privacy policy",
        sections: [
            ("Who is responsible", "Momoko is developed and operated by Martin Lasek. This policy explains how information is handled when you play Momoko, use its optional online features, or contact support. Contact heylasek@gmail.com for privacy questions or requests."),
            ("Game progress on your device", "Momoko stores progress, settings, Moko balances, character unlocks, and purchase-delivery records on your device. These records allow the game to remember your progress and avoid delivering the same purchase twice. Deleting the app may remove local progress. Local storage is separate from the analytics described below."),
            ("Optional iCloud Save", "If you enable iCloud Save, Momoko uses Apple's CloudKit service to synchronize your Moko balance, unlocked characters, and the records needed to reconcile earnings, spending, and purchase delivery. These records are associated with your iCloud account in a private CloudKit database. This does not give Momoko your Apple Account password. Revive credits and other game progress are not included in this save. You can turn synchronization off in Settings; turning it off does not delete an existing cloud save. Apple provides controls for managing app data in iCloud."),
            ("Purchases", "Apple processes in-app payments. Momoko receives StoreKit transaction information, including product and transaction identifiers, purchase status and dates, to verify purchases, deliver content, and prevent duplicate delivery. We do not receive your payment-card details. Purchase and shop interactions may also be measured to understand product use and improve the purchase experience; this is not advertising tracking."),
            ("Gameplay analytics", "Momoko uses PostHog to understand usage, improve gameplay balance, and identify problems. Events include app opens, runs, waves, upgrades, and revives, with information such as duration, outcomes, and game version. PostHog associates events with a randomly generated installation identifier and session identifiers, and receives technical information such as device model, operating-system version, app version, language, and screen dimensions. These identifiers can link events over time even without your name. The configured analytics service is hosted in the United States. Internet requests also expose an IP address to the receiving service; Momoko disables PostHog's geographic enrichment of its analytics events."),
            ("What analytics do not include", "Momoko does not enable PostHog session replay, screen recording, or automatic tap capture. We do not use this analytics integration for cross-app advertising, sell personal information, or share it for targeted advertising. Not providing a name does not make all analytics data anonymous."),
            ("Game Center", "If you use Game Center, Apple handles sign-in and leaderboard services. Momoko submits scores to the leaderboard. Your Game Center profile and scores may be visible to others according to Apple's services and your account settings."),
            ("Feedback and support", "The in-app feedback feature uses WishKit. Feedback, votes, and comments you choose to submit are processed by that service, together with identifiers needed to operate it and any contact information you provide. Feedback-board contributions may be visible to other users. If you email us, we receive your email address and the contents and attachments of your message. Do not send passwords, payment-card details, or sensitive personal information."),
            ("Why information is used and shared", "Information is used to deliver purchases and requested online features, preserve progress, respond to support requests, and improve the game. It is shared with the service providers needed for those purposes, including Apple, PostHog, WishKit, and email providers. Information may also be disclosed when legally required or necessary to protect users and the service. Where applicable, processing relies on providing requested services, legitimate interests in maintaining and improving the game, legal obligations, or consent when required."),
            ("Retention and security", "Local save and transaction records are retained to maintain progress and prevent duplicate grants. Cloud records remain until removed using available iCloud controls. Analytics and support records are retained for the purposes described here, subject to provider retention settings and any legal requirements. We use the security mechanisms provided by Apple and our service providers, but cannot guarantee absolute security. Removing the app does not automatically delete information already received by an online service."),
            ("Your choices and rights", "Optional features such as iCloud Save, Game Center, and feedback can be left unused. Depending on your location, you may have rights to request access, correction, deletion, restriction, portability, or to object to processing and complain to a data-protection authority. Email heylasek@gmail.com to make a request or ask about analytics choices. We may need information to locate the relevant records and verify the request; installation-based records cannot necessarily be located from an email address alone. We do not promise an in-app analytics switch or automatic deletion feature that is not present in your version."),
            ("Children", "Momoko is not directed to children under 13. If you believe a child has provided personal information through Momoko, please contact us so we can investigate and address it. Parents and guardians can use Apple's parental and purchase controls."),
            ("This website and policy changes", "These app-information pages do not embed analytics scripts or third-party fonts. The website hosting service may process ordinary request logs, including IP addresses, for delivery and security. Other pages on this website may use different services. We may update this policy as Momoko changes; the date above identifies the latest revision.")
        ],
        referenceLinks: [
            ("Apple privacy policy", "https://www.apple.com/legal/privacy/"),
            ("PostHog privacy policy", "https://posthog.com/privacy"),
            ("WishKit", "https://www.wishkit.io")
        ]
    )

    static let terms = AppInfoPage(
        appName: "Momoko", appSlug: "momoko", slug: "terms", title: "Terms of use",
        sections: [
            ("About these terms", "Momoko is provided by Martin Lasek. These terms explain use of the game and its optional purchases. Apple's Standard Licensed Application End User License Agreement also applies where no custom EULA is supplied in the App Store. Nothing here limits mandatory consumer rights or rights under Apple's applicable terms."),
            ("Using the game", "Use Momoko lawfully and do not exploit purchase systems, disrupt online services, impersonate others, or submit abusive or unlawful feedback. Follow the age rating and any parental-consent requirements that apply to you. Game content and software remain the property of their respective owners."),
            ("Mokos and digital content", "Mokos are virtual currency for use within Momoko. They are not money, do not earn interest, and cannot be redeemed for cash or transferred outside the supported game features. The app displays the amount and price before an optional purchase. Unlocking a character spends the stated number of Mokos. Buying currency does not automatically unlock or equip a character. Purchased in-game currency does not expire."),
            ("Revives", "A revive purchase provides one use. It normally continues the current run after defeat. If purchase delivery is interrupted, an available saved credit can be used at a later Game Over without another charge. After a revive is used, a later revive requires another credit or purchase. Saved revive credits are local to the device, not part of iCloud Save."),
            ("Payment and refunds", "Apple handles checkout, payment authorization, and refund requests for App Store purchases. Prices and currencies are shown by the App Store and may vary by region. To request a refund, use Apple's Report a Problem service. Refund eligibility is governed by applicable law and Apple's process; these terms do not remove statutory refund rights."),
            ("Progress and availability", "Gameplay can be available offline, but purchases, synchronization, leaderboards, and other online features require connectivity. iCloud Save is optional and covers only the progress described in the app and privacy policy. Deleting the app, losing a device, changing accounts, or disabling synchronization can affect recovery. Do not assume Apple purchase history can reconstruct an unspent consumable balance. We aim to keep the game reliable but cannot promise uninterrupted service or recovery of every local-only save."),
            ("Updates and your rights", "Game features and balance may change through updates. Any changes remain subject to applicable consumer protections. These terms do not exclude liability that cannot lawfully be excluded. For questions about purchases, access, or these terms, contact heylasek@gmail.com.")
        ],
        referenceLinks: [
            ("Apple Standard EULA", "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/"),
            ("Request a refund from Apple", "https://reportaproblem.apple.com")
        ]
    )

    static let support = AppInfoPage(
        appName: "Momoko", appSlug: "momoko", slug: "support", title: "Support",
        sections: [
            ("Contact", "Email heylasek@gmail.com with Momoko in the subject. Include your app version, iOS version, device model, and a short description of what happened. A screenshot can help. Do not include passwords, full receipts, or payment-card information."),
            ("A purchase has not appeared", "Do not buy again just to retry delivery. Reopen Momoko with an internet connection and check whether the content arrives. If the shop offers a delivery Retry action, use it. If the issue continues, contact support before deleting or reinstalling the app, because that can remove local progress."),
            ("Interrupted revive", "If a revive payment completed while the app was closed, reopen the game and check the next Game Over screen. A recovered credit should allow one revive without a price or a new checkout. If another payment dialog appears unexpectedly, cancel it and contact support."),
            ("iCloud Save", "Use the same iCloud account on your devices and enable iCloud Save in Momoko's Settings. Allow an internet connection for synchronization. This saves Mokos and unlocked characters, not every kind of progress or local revive credits. Turning the switch off stops synchronization; it does not erase the cloud save."),
            ("Refund requests", "Apple handles App Store refund requests at reportaproblem.apple.com. Contact Apple through that service for billing and refund decisions."),
            ("Ideas and privacy questions", "Use Feedback in the app for feature ideas, or email us directly. Send privacy and deletion requests by email rather than posting personal information on the public feedback board.")
        ],
        referenceLinks: [("Apple billing and refunds", "https://reportaproblem.apple.com")]
    )
}
