import HtmlVaporSupport

enum SocialLinks {
    static var content: Node {
        .div(attributes: [.class("site-social-links")],
            link(label: "Martin on X", destination: "https://twitter.com/martinlasek", path: "M18.901 1.153h3.68l-8.04 9.19L24 22.846h-7.406l-5.8-7.584-6.64 7.584H.47l8.6-9.835L0 1.154h7.594l5.243 6.932zm-1.29 19.49h2.039L6.487 3.24H4.3z"),
            link(label: "Martin on GitHub", destination: "https://github.com/martinlasek", path: "M12 .297C5.37.297 0 5.67 0 12.297c0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.725-4.043-1.61-4.043-1.61-.546-1.387-1.333-1.756-1.333-1.756-1.09-.745.083-.73.083-.73 1.205.085 1.838 1.237 1.838 1.237 1.07 1.835 2.807 1.305 3.492.998.108-.776.42-1.305.763-1.605-2.665-.303-5.467-1.334-5.467-5.93 0-1.31.467-2.38 1.235-3.22-.124-.303-.535-1.523.117-3.176 0 0 1.008-.322 3.3 1.23A11.51 11.51 0 0 1 12 6.1c1.02.005 2.045.138 3.003.404 2.29-1.552 3.295-1.23 3.295-1.23.653 1.653.242 2.873.12 3.176.77.84 1.233 1.91 1.233 3.22 0 4.61-2.807 5.624-5.48 5.92.43.372.823 1.102.823 2.222 0 1.606-.015 2.9-.015 3.293 0 .322.216.694.825.576C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12")
        )
    }

    private static func link(label: String, destination: String, path: String) -> Node {
        .a(attributes: [.href(destination), .class("site-social-link"), .init("aria-label", label)],
            // Fixed icon geometry; no user-controlled values enter this markup.
            .raw("<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 24 24\" width=\"22\" height=\"22\" fill=\"currentColor\" aria-hidden=\"true\" focusable=\"false\"><path d=\"\(path)\"/></svg>"))
    }
}
