connection: "bq_rduong"

include: "/views/**/*.view" # include all the views
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
connection: "looker-private-demo"
label: " eCommerce"
include: "/views/**/*.view" # include all the views


explore: ga_events_data {
  label: "Events"
  view_name: ga_events_data
  }
