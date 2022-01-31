/**
 * $File: main.js $
 * $Date: 2022-01-22 23:53:52 $
 * $Revision: $
 * $Creator: Jen-Chieh Shen $
 * $Notice: See LICENSE.txt for modification and distribution information
 *                   Copyright © 2022 by Shen, Jen-Chieh $
 */

"use strict";

const base_url = "https://github.com/jcs-emacs/jcs-elpa/blob/master/";
const base_url_raw = "https://raw.githubusercontent.com/jcs-emacs/jcs-elpa/";
const archive_url = base_url_raw + "master/docs/archive.json";

var archive = null;

$(document).ready(function(){
  var packageList = $('#package-list');
  var state = $('#state');
  var table = $('#package-table');

  $.getJSON(archive_url, function(data){
    archive = data;
    state.text('Current List of ' + archive.length + ' Packages');
    table.DataTable({
      "data": archive,
      "bLengthChange": false,
      "pageLength": '50',
      "processing": true,
      "autoWidth": false,
      "destroy": true,
      "scrollCollapse": true,
      "dom": 'lrt',
      "language": {
        search: "",
        "searchPlaceholder": "Enter filter terms",
      },
      "columns": [
        { /* Name */
          "render": function (data, type, row, meta) {
            return '<a href="' + row.url + '">' + row.name + '</a>';
          },
        },
        { /* Summary */
          "render": function (data, type, row, meta) {
            return '<a href="' + row.url + '">' + row.summary + '</a>';
          },
        },
        { /* Version */
          "render": function (data, type, row, meta) {
            return '<a href="' + row.url + '">' + row.version + ' ⮛</a>';
          }
        },
        { /* Recipe */
          "render": function (data, type, row, meta) {
            return '<a href="' + base_url + 'recipes/' + row.name + '">🍴</a>';
          }
        },
        { /* Source */
          "render": function (data, type, row, meta) {
            return '<a href="' + row.tree + '">' + row.source + '</a>';
          },

        },
        { /* Badge */
          "render": function (data, type, row, meta) {
            return '<img src="' + base_url_raw + 'master/badges/v/' + row.name + '.svg"/>';
          }
        },
      ],
    });

  }).fail(function(){
    console.log("An error has occurred.");
  });

  /* Replace search box with my own filter input! */
  $('#filter').keyup(function () {
    table.dataTable().fnFilter(this.value);
  });
});
