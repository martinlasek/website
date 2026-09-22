import HtmlVaporSupport

enum SocialLinks {
    static var content: Node {
        .div(attributes: [.class("site-social-links")],
            link(label: "Martin on X", destination: "https://twitter.com/martinlasek", path: "M18.901 1.153h3.68l-8.04 9.19L24 22.846h-7.406l-5.8-7.584-6.64 7.584H.47l8.6-9.835L0 1.154h7.594l5.243 6.932zm-1.29 19.49h2.039L6.487 3.24H4.3z"),
            link(label: "Martin on Instagram", destination: "https://www.instagram.com/martinlasek/", path: "M7 2h10a5 5 0 0 1 5 5v10a5 5 0 0 1-5 5H7a5 5 0 0 1-5-5V7a5 5 0 0 1 5-5zm0 2a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h10a3 3 0 0 0 3-3V7a3 3 0 0 0-3-3H7zm5 3a5 5 0 1 1 0 10 5 5 0 0 1 0-10zm0 2a3 3 0 1 0 0 6 3 3 0 0 0 0-6zm6.5-2.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"),
            link(label: "Martin on YouTube", destination: "https://www.youtube.com/@martinlasek", path: "M21.58 7.19a2.5 2.5 0 0 0-1.76-1.77C18.26 5 12 5 12 5s-6.26 0-7.82.42a2.5 2.5 0 0 0-1.76 1.77C2 8.75 2 12 2 12s0 3.25.42 4.81a2.5 2.5 0 0 0 1.76 1.77C5.74 19 12 19 12 19s6.26 0 7.82-.42a2.5 2.5 0 0 0 1.76-1.77C22 15.25 22 12 22 12s0-3.25-.42-4.81zM10 15V9l5.2 3-5.2 3z"),
            link(label: "Martin on TikTok", destination: "https://www.tiktok.com/@martinlasek", path: "M16.6 2c.4 2.3 1.7 3.7 4.1 3.9v3.2a8.2 8.2 0 0 1-4.1-1.2v7.3a6.5 6.5 0 1 1-5.6-6.4v3.3a3.3 3.3 0 1 0 2.3 3.1V2h3.3z")
        )
    }

    private static func link(label: String, destination: String, path: String) -> Node {
        .a(attributes: [.href(destination), .class("site-social-link"), .init("aria-label", label)],
            // Fixed icon geometry; no user-controlled values enter this markup.
            .raw("<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\" width=\"22\" height=\"22\" fill=\"currentColor\" fill-rule=\"evenodd\" aria-hidden=\"true\" focusable=\"false\"><path d=\"\(path)\"/></svg>"))
    }
}
