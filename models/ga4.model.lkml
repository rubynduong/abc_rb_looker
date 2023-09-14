connection: "bq_rduong"

include: "/ga4_views/*.view.lkml"                # include all views in the views/ folder in this project
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
# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: events_data {
  hidden: yes
  join: events_data__items {
    view_label: "Events Data: Items"
    sql: LEFT JOIN UNNEST(${events_data.items}) as events_data__items ;;
    relationship: one_to_many
  }
  join: events_data__event_params {
    view_label: "Events Data: Event Params"
    sql: LEFT JOIN UNNEST(${events_data.event_params}) as events_data__event_params ;;
    relationship: one_to_many
  }
  join: events_data__user_properties {
    view_label: "Events Data: User Properties"
    sql: LEFT JOIN UNNEST(${events_data.user_properties}) as events_data__user_properties ;;
    relationship: one_to_many
  }
}
