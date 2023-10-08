# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
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
pin "tom-select", to: "https://ga.jspm.io/npm:tom-select@2.2.2/dist/js/tom-select.complete.js"
pin "stimulus_reflex", to: "https://ga.jspm.io/npm:stimulus_reflex@3.5.0-rc3/dist/stimulus_reflex.js"
pin "@rails/actioncable", to: "https://ga.jspm.io/npm:@rails/actioncable@7.1.0/app/assets/javascripts/actioncable.esm.js"
pin "cable_ready", to: "https://ga.jspm.io/npm:cable_ready@5.0.1/dist/cable_ready.js"
pin "morphdom", to: "https://ga.jspm.io/npm:morphdom@2.6.1/dist/morphdom.js"
