import HtmlVaporSupport

enum Analytics {
    static func scripts(isEnabled: Bool) -> Node {
        guard isEnabled else { return .fragment([]) }
        return .raw("""
        <script async src="https://www.googletagmanager.com/gtag/js?id=G-EV6Z0YNYR1"></script>
        <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'G-EV6Z0YNYR1');
        </script>
        """)
    }
}
