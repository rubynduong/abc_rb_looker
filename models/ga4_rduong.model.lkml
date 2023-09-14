connection: "bq_rduong"
label: "GA4 - Looker"
include: "/views/**/*.view" # include all the views

explore: ga_events_data {
  label: "Events"
  view_name: ga_events_data
  }
