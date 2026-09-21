// Runs after the deferred core and Swift grammar; keep plain code on load failures.
if (window.Prism && Prism.languages.swift) {
    Prism.highlightAll();
}
