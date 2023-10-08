// Import and register all your controllers from the importmap under controllers/*

import StimulusReflex from "stimulus_reflex";
import { application } from "controllers/application";

import { cable } from "@hotwired/turbo-rails"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
eagerLoadControllersFrom("controllers", application);

// Eager load all controllers defined in the import map under app/components
//eagerLoadControllersFrom("components", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

// Import and register all TailwindCSS Components
import {
  Alert,
  Dropdown,
  Modal,
  Tabs,
  Popover,
  Toggle,
  Slideover,
} from "tailwindcss-stimulus-components";
application.register("alert", Alert);
//application.register('autosave', Autosave)
application.register("dropdown", Dropdown);
application.register("modal", Modal);
application.register("tabs", Tabs);
application.register("popover", Popover);
application.register("toggle", Toggle);
application.register("slideover", Slideover);

import DropzoneController from "stimulus-dropzone";
application.register("dropzone", DropzoneController);

import { Autocomplete } from "stimulus-autocomplete";
application.register("autocomplete", Autocomplete);

import NestedForm from 'stimulus-rails-nested-form';
application.register('nested-form', NestedForm);

// Stimulus Reflex
const consumer = await cable.getConsumer()
StimulusReflex.initialize(application, { consumer, debug: true });
