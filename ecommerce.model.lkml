connection: "looker-private-demo"
label: " eCommerce"
include: "/views/**/*.view" # include all the views

############ Model Configuration #############

datagroup: ecommerce_etl {
  sql_trigger: SELECT max(created_at) FROM ecomm.events ;;
  max_cache_age: "24 hours"
}

persist_with: ecommerce_etl
############ Base Explores #############

explore: order_items {
  label: "Orders, Items and Users"
  access_filter: {
    field: products.brand
    user_attribute: abc_rb_demo_brand
  }
  view_name: order_items

  join: inventory_items {
    view_label: "Inventory Items"
    #Left Join only brings in items that have been sold as order_item
    type: full_outer
    relationship: one_to_one
    sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
  }
  join: users {
    view_label: "Users"
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }

  join: products {
    view_label: "Products"
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.id} = ${inventory_items.product_id} ;;
  }

  join: distribution_centers {
    view_label: "Distribution Center"
    type: left_outer
    sql_on: ${distribution_centers.id} = ${inventory_items.product_distribution_center_id} ;;
    relationship: many_to_one
  }
  #roll up table for commonly used queries
  # aggregate_table: simple_rollup {
  #   query: {
  #     dimensions: [created_date, products.brand, products.category, products.department]
  #     measures: [count, returned_count, returned_total_sale_price, total_gross_margin, total_sale_price]
  #     filters: [order_items.created_date: "6 months"]
  #   }
  #   materialization: {
  #     datagroup_trigger: ecommerce_etl
  #   }
  # }
}
