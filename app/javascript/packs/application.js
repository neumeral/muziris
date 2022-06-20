// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("jquery");
import $ from "jquery";
//= require bootstrap-datepicker
//= require jquery-3.2.1.slim.min
//= require popper.min
//= require bootstrap.min

import "bootstrap";
import "select2";
import "select2/dist/css/select2.css";

//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require bootstrap-datepicker/locales/bootstrap-datepicker.fr.js

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
//= require Chart.min

$(document).ready(function () {
  $(".datepicker").datepicker({
    format: "dd/mm/yyyy",
  });
});

$(document).on("turbolinks:load", () => {
  $(".select2").select2({
    placeholder: "Choose a product",
    allowClear: true,
  });
});
