# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.1/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "tailwindcss-stimulus-components", to: "https://ga.jspm.io/npm:tailwindcss-stimulus-components@3.0.4/dist/tailwindcss-stimulus-components.modern.js"
pin "lodash/debounce", to: "https://ga.jspm.io/npm:lodash@4.17.21/debounce.js"
pin "dropzone", to: "https://ga.jspm.io/npm:dropzone@6.0.0-beta.1/dist/dropzone.mjs"
pin "stimulus-dropzone", to: "/stimulus-dropzone/src/index.js"
pin "just-extend", to: "https://ga.jspm.io/npm:just-extend@5.1.1/index.esm.js"
pin "@kanety/stimulus-static-actions", to: "https://ga.jspm.io/npm:@kanety/stimulus-static-actions@1.0.1/dist/index.modern.js"
pin "stimulus-autocomplete", to: "https://ga.jspm.io/npm:stimulus-autocomplete@3.1.0/src/autocomplete.js"
pin "stimulus-rails-nested-form", to: "https://ga.jspm.io/npm:stimulus-rails-nested-form@4.1.0/dist/stimulus-rails-nested-form.mjs"
