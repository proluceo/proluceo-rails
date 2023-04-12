# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.0.1/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "tailwindcss-stimulus-components", to: "https://ga.jspm.io/npm:tailwindcss-stimulus-components@3.0.4/dist/tailwindcss-stimulus-components.modern.js"
pin "lodash/debounce", to: "https://ga.jspm.io/npm:lodash@4.17.21/debounce.js"
pin "dropzone", to: "https://ga.jspm.io/npm:dropzone@6.0.0-beta.1/dist/dropzone.mjs"
pin "just-extend", to: "https://ga.jspm.io/npm:just-extend@5.1.1/index.esm.js"
