import Vapor
import Leaf
import HtmlVaporSupport

func routes(_ app: Vapor.Application) throws {
    app.get { req throws -> Response in
        return req.redirect(to: NavLink.tutorials.href)
    }

    app.get("\(NavLink.tutorials.href)") { req throws -> Node in
        PageBuilder.base(canonUrlPath: NavLink.tutorials) {
            .fragment(Article.all.map(Article.excerpt))
        }
    }

    for article in Article.all {
        app.get("\(NavLink.tutorials.href)", "\(article.slug)") { req throws -> Node in
            PageBuilder.base(canonUrlPath: .tutorials, article.node)
        }
    }

    app.get("\(NavLink.projects.href)") { req throws -> Node in
        PageBuilder.base(canonUrlPath: .projects) {
            .h1("Coming Soon")
        }
    }

    app.get("\(NavLink.sponsorship.href)") { req throws -> Node in
        PageBuilder.base(canonUrlPath: .sponsorship) {
            .h1("Coming Soon")
        }
    }

    app.get("\(NavLink.about.href)") { req throws -> Node in
        PageBuilder.base(canonUrlPath: .about) {
            .div(attributes: [.class("c-card bg-body-tertiary")],
                 .h1("About"),

                .p("""
                    I have always been passionate about learning new and challenging technologies to then break it down into straight forward and digestible tutorials.
                    Following very much the idea of:
                """),

                .p(attributes: [.class("h5 fw-light p-3")],
                   .i("""
                        "If you can't explain it to a six-year-old, you don't understand it yourself." - Albert Einstein
                    """)
                ),

                .p("""
                    I hope you will find value in the value I create. Don't hesitate to reach out anytime if you have any questions or feedback. Your input is always appreciated!
                """)
            )
        }
    }
}
