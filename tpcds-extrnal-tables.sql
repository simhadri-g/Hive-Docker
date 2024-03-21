set hive.exec.max.dynamic.partitions=20000;
set hive.exec.max.dynamic.partitions.pernode=20000;

create database if not exists externalORC;
use externalORC;

!sh echo START EXECUTE etl tpcds.realschema convert;
!sh date +%s.%N;

drop table if exists call_center;
create external table call_center
stored as ORC
as select * from tpcds_1000_text.call_center;

drop table if exists catalog_page;
create external table catalog_page
stored as ORC
as select * from tpcds_1000_text.catalog_page;

drop table if exists catalog_returns;
create external table catalog_returns
(
    cr_returned_time_sk       int                           ,
    cr_item_sk                int                           ,
    cr_refunded_customer_sk   int                           ,
    cr_refunded_cdemo_sk      int                           ,
    cr_refunded_hdemo_sk      int                           ,
    cr_refunded_addr_sk       int                           ,
    cr_returning_customer_sk  int                           ,
    cr_returning_cdemo_sk     int                           ,
    cr_returning_hdemo_sk     int                           ,
    cr_returning_addr_sk      int                           ,
    cr_call_center_sk         int                           ,
    cr_catalog_page_sk        int                           ,
    cr_ship_mode_sk           int                           ,
    cr_warehouse_sk           int                           ,
    cr_reason_sk              int                           ,
    cr_order_number           int                           ,
    cr_return_quantity        int                           ,
    cr_return_amount          decimal(7,2)                  ,
    cr_return_tax             decimal(7,2)                  ,
    cr_return_amt_inc_tax     decimal(7,2)                  ,
    cr_fee                    decimal(7,2)                  ,
    cr_return_ship_cost       decimal(7,2)                  ,
    cr_refunded_cash          decimal(7,2)                  ,
    cr_reversed_charge        decimal(7,2)                  ,
    cr_store_credit           decimal(7,2)                  ,
    cr_net_loss               decimal(7,2)
)
partitioned by (cr_returned_date_sk int)
stored as ORC;

insert overwrite table catalog_returns partition (cr_returned_date_sk)
select
    cr.cr_returned_time_sk, cr.cr_item_sk, cr.cr_refunded_customer_sk,
    cr.cr_refunded_cdemo_sk, cr.cr_refunded_hdemo_sk, cr.cr_refunded_addr_sk,
    cr.cr_returning_customer_sk, cr.cr_returning_cdemo_sk, cr.cr_returning_hdemo_sk,
    cr.cr_returning_addr_sk, cr.cr_call_center_sk, cr.cr_catalog_page_sk,
    cr.cr_ship_mode_sk, cr.cr_warehouse_sk, cr.cr_reason_sk,
    cr.cr_order_number, cr.cr_return_quantity, cr.cr_return_amount,
    cr.cr_return_tax, cr.cr_return_amt_inc_tax, cr.cr_fee,
    cr.cr_return_ship_cost, cr.cr_refunded_cash, cr.cr_reversed_charge,
    cr.cr_store_credit, cr.cr_net_loss, cr.cr_returned_date_sk
from tpcds_1000_text.catalog_returns cr;

drop table if exists catalog_sales;
create external table catalog_sales
(
    cs_sold_time_sk           int                           ,
    cs_ship_date_sk           int                           ,
    cs_bill_customer_sk       int                           ,
    cs_bill_cdemo_sk          int                           ,
    cs_bill_hdemo_sk          int                           ,
    cs_bill_addr_sk           int                           ,
    cs_ship_customer_sk       int                           ,
    cs_ship_cdemo_sk          int                           ,
    cs_ship_hdemo_sk          int                           ,
    cs_ship_addr_sk           int                           ,
    cs_call_center_sk         int                           ,
    cs_catalog_page_sk        int                           ,
    cs_ship_mode_sk           int                           ,
    cs_warehouse_sk           int                           ,
    cs_item_sk                int                           ,
    cs_promo_sk               int                           ,
    cs_order_number           int                           ,
    cs_quantity               int                           ,
    cs_wholesale_cost         decimal(7,2)                  ,
    cs_list_price             decimal(7,2)                  ,
    cs_sales_price            decimal(7,2)                  ,
    cs_ext_discount_amt       decimal(7,2)                  ,
    cs_ext_sales_price        decimal(7,2)                  ,
    cs_ext_wholesale_cost     decimal(7,2)                  ,
    cs_ext_list_price         decimal(7,2)                  ,
    cs_ext_tax                decimal(7,2)                  ,
    cs_coupon_amt             decimal(7,2)                  ,
    cs_ext_ship_cost          decimal(7,2)                  ,
    cs_net_paid               decimal(7,2)                  ,
    cs_net_paid_inc_tax       decimal(7,2)                  ,
    cs_net_paid_inc_ship      decimal(7,2)                  ,
    cs_net_paid_inc_ship_tax  decimal(7,2)                  ,
    cs_net_profit             decimal(7,2)
)
partitioned by (cs_sold_date_sk int)
stored as ORC;

insert overwrite table catalog_sales partition (cs_sold_date_sk)
select
    cs.cs_sold_time_sk, cs.cs_ship_date_sk, cs.cs_bill_customer_sk,
    cs.cs_bill_cdemo_sk, cs.cs_bill_hdemo_sk, cs.cs_bill_addr_sk,
    cs.cs_ship_customer_sk, cs.cs_ship_cdemo_sk, cs.cs_ship_hdemo_sk,
    cs.cs_ship_addr_sk, cs.cs_call_center_sk, cs.cs_catalog_page_sk,
    cs.cs_ship_mode_sk, cs.cs_warehouse_sk, cs.cs_item_sk,
    cs.cs_promo_sk, cs.cs_order_number, cs.cs_quantity,
    cs.cs_wholesale_cost, cs.cs_list_price, cs.cs_sales_price,
    cs.cs_ext_discount_amt, cs.cs_ext_sales_price, cs.cs_ext_wholesale_cost,
    cs.cs_ext_list_price, cs.cs_ext_tax, cs.cs_coupon_amt,
    cs.cs_ext_ship_cost, cs.cs_net_paid, cs.cs_net_paid_inc_tax,
    cs.cs_net_paid_inc_ship, cs.cs_net_paid_inc_ship_tax, cs.cs_net_profit,
    cs.cs_sold_date_sk
from tpcds_1000_text.catalog_sales cs;

drop table if exists customer;
create external table customer
stored as ORC
as select * from tpcds_1000_text.customer;

drop table if exists customer_address;
create external table customer_address
stored as ORC
as select * from tpcds_1000_text.customer_address;

drop table if exists customer_demographics;
create external table customer_demographics
stored as ORC
as select * from tpcds_1000_text.customer_demographics;

drop table if exists date_dim;
create external table date_dim
stored as ORC
as select * from tpcds_1000_text.date_dim;

drop table if exists household_demographics;
create external table household_demographics
stored as ORC
as select * from tpcds_1000_text.household_demographics;

drop table if exists income_band;
create external table income_band
stored as ORC
as select * from tpcds_1000_text.income_band;

drop table if exists inventory;
create external table inventory
(
    inv_date_sk               int                           ,
    inv_item_sk               int                           ,
    inv_warehouse_sk          int                           ,
    inv_quantity_on_hand      int
)
partitioned by (inv_date string)
stored as ORC;

insert overwrite table inventory partition (inv_date)
select
    i.inv_date_sk, i.inv_item_sk, i.inv_warehouse_sk,
    i.inv_quantity_on_hand, d.d_date as inv_date
from tpcds_1000_text.inventory i
join tpcds_1000_text.date_dim d
on (d.d_date_sk = i.inv_date_sk);

drop table if exists item;
create external table item
stored as ORC
as select * from tpcds_1000_text.item;

drop table if exists promotion;
create external table promotion
stored as ORC
as select * from tpcds_1000_text.promotion;

drop table if exists reason;
create external table reason
stored as ORC
as select * from tpcds_1000_text.reason;

drop table if exists ship_mode;
create external table ship_mode
stored as ORC
as select * from tpcds_1000_text.ship_mode;

drop table if exists store;
create external table store
stored as ORC
as select * from tpcds_1000_text.store;

drop table if exists store_returns;
create external table store_returns
(
    sr_return_time_sk         int                           ,
    sr_item_sk                int                           ,
    sr_customer_sk            int                           ,
    sr_cdemo_sk               int                           ,
    sr_hdemo_sk               int                           ,
    sr_addr_sk                int                           ,
    sr_store_sk               int                           ,
    sr_reason_sk              int                           ,
    sr_ticket_number          int                           ,
    sr_return_quantity        int                           ,
    sr_return_amt             decimal(7,2)                  ,
    sr_return_tax             decimal(7,2)                  ,
    sr_return_amt_inc_tax     decimal(7,2)                  ,
    sr_fee                    decimal(7,2)                  ,
    sr_return_ship_cost       decimal(7,2)                  ,
    sr_refunded_cash          decimal(7,2)                  ,
    sr_reversed_charge        decimal(7,2)                  ,
    sr_store_credit           decimal(7,2)                  ,
    sr_net_loss               decimal(7,2)
)
partitioned by (sr_returned_date_sk int)
stored as ORC;

insert overwrite table store_returns partition (sr_returned_date_sk)
select
    sr.sr_return_time_sk, sr.sr_item_sk, sr.sr_customer_sk,
    sr.sr_cdemo_sk, sr.sr_hdemo_sk, sr.sr_addr_sk,
    sr.sr_store_sk, sr.sr_reason_sk, sr.sr_ticket_number,
    sr.sr_return_quantity, sr.sr_return_amt, sr.sr_return_tax,
    sr.sr_return_amt_inc_tax, sr.sr_fee, sr.sr_return_ship_cost,
    sr.sr_refunded_cash, sr.sr_reversed_charge, sr.sr_store_credit,
    sr.sr_net_loss, sr.sr_returned_date_sk
from tpcds_1000_text.store_returns sr;

drop table if exists store_sales;
create external table store_sales
(
    ss_sold_time_sk           int                           ,
    ss_item_sk                int                           ,
    ss_customer_sk            int                           ,
    ss_cdemo_sk               int                           ,
    ss_hdemo_sk               int                           ,
    ss_addr_sk                int                           ,
    ss_store_sk               int                           ,
    ss_promo_sk               int                           ,
    ss_ticket_number          int                           ,
    ss_quantity               int                           ,
    ss_wholesale_cost         decimal(7,2)                  ,
    ss_list_price             decimal(7,2)                  ,
    ss_sales_price            decimal(7,2)                  ,
    ss_ext_discount_amt       decimal(7,2)                  ,
    ss_ext_sales_price        decimal(7,2)                  ,
    ss_ext_wholesale_cost     decimal(7,2)                  ,
    ss_ext_list_price         decimal(7,2)                  ,
    ss_ext_tax                decimal(7,2)                  ,
    ss_coupon_amt             decimal(7,2)                  ,
    ss_net_paid               decimal(7,2)                  ,
    ss_net_paid_inc_tax       decimal(7,2)                  ,
    ss_net_profit             decimal(7,2)
)
partitioned by (ss_sold_date_sk int)
stored as ORC;

insert overwrite table store_sales partition (ss_sold_date_sk)
select
    ss.ss_sold_time_sk, ss.ss_item_sk, ss.ss_customer_sk,
    ss.ss_cdemo_sk, ss.ss_hdemo_sk, ss.ss_addr_sk,
    ss.ss_store_sk, ss.ss_promo_sk, ss.ss_ticket_number,
    ss.ss_quantity, ss.ss_wholesale_cost, ss.ss_list_price,
    ss.ss_sales_price, ss.ss_ext_discount_amt, ss.ss_ext_sales_price,
    ss.ss_ext_wholesale_cost, ss.ss_ext_list_price, ss.ss_ext_tax,
    ss.ss_coupon_amt, ss.ss_net_paid, ss.ss_net_paid_inc_tax,
    ss.ss_net_profit, ss.ss_sold_date_sk
from tpcds_1000_text.store_sales ss;

drop table if exists time_dim;
create external table time_dim
stored as ORC
as select * from tpcds_1000_text.time_dim;

drop table if exists warehouse;
create external table warehouse
stored as ORC
as select * from tpcds_1000_text.warehouse;

drop table if exists web_page;
create external table web_page
stored as ORC
as select * from tpcds_1000_text.web_page;

drop table if exists web_returns;
create external table web_returns
(
    wr_returned_time_sk       int                           ,
    wr_item_sk                int                           ,
    wr_refunded_customer_sk   int                           ,
    wr_refunded_cdemo_sk      int                           ,
    wr_refunded_hdemo_sk      int                           ,
    wr_refunded_addr_sk       int                           ,
    wr_returning_customer_sk  int                           ,
    wr_returning_cdemo_sk     int                           ,
    wr_returning_hdemo_sk     int                           ,
    wr_returning_addr_sk      int                           ,
    wr_web_page_sk            int                           ,
    wr_reason_sk              int                           ,
    wr_order_number           int                           ,
    wr_return_quantity        int                           ,
    wr_return_amt             decimal(7,2)                  ,
    wr_return_tax             decimal(7,2)                  ,
    wr_return_amt_inc_tax     decimal(7,2)                  ,
    wr_fee                    decimal(7,2)                  ,
    wr_return_ship_cost       decimal(7,2)                  ,
    wr_refunded_cash          decimal(7,2)                  ,
    wr_reversed_charge        decimal(7,2)                  ,
    wr_account_credit         decimal(7,2)                  ,
    wr_net_loss               decimal(7,2)
)
partitioned by (wr_returned_date_sk int)
stored as ORC;

insert overwrite table web_returns partition (wr_returned_date_sk)
select
    wr.wr_returned_time_sk, wr.wr_item_sk, wr.wr_refunded_customer_sk,
    wr.wr_refunded_cdemo_sk, wr.wr_refunded_hdemo_sk, wr.wr_refunded_addr_sk,
    wr.wr_returning_customer_sk, wr.wr_returning_cdemo_sk, wr.wr_returning_hdemo_sk,
    wr.wr_returning_addr_sk, wr.wr_web_page_sk, wr.wr_reason_sk,
    wr.wr_order_number, wr.wr_return_quantity, wr.wr_return_amt,
    wr.wr_return_tax, wr.wr_return_amt_inc_tax, wr.wr_fee,
    wr.wr_return_ship_cost, wr.wr_refunded_cash, wr.wr_reversed_charge,
    wr.wr_account_credit, wr.wr_net_loss, wr.wr_returned_date_sk
from tpcds_1000_text.web_returns wr;

drop table if exists web_sales;
create external table web_sales
(
    ws_sold_time_sk           int                           ,
    ws_ship_date_sk           int                           ,
    ws_item_sk                int                           ,
    ws_bill_customer_sk       int                           ,
    ws_bill_cdemo_sk          int                           ,
    ws_bill_hdemo_sk          int                           ,
    ws_bill_addr_sk           int                           ,
    ws_ship_customer_sk       int                           ,
    ws_ship_cdemo_sk          int                           ,
    ws_ship_hdemo_sk          int                           ,
    ws_ship_addr_sk           int                           ,
    ws_web_page_sk            int                           ,
    ws_web_site_sk            int                           ,
    ws_ship_mode_sk           int                           ,
    ws_warehouse_sk           int                           ,
    ws_promo_sk               int                           ,
    ws_order_number           int                           ,
    ws_quantity               int                           ,
    ws_wholesale_cost         decimal(7,2)                  ,
    ws_list_price             decimal(7,2)                  ,
    ws_sales_price            decimal(7,2)                  ,
    ws_ext_discount_amt       decimal(7,2)                  ,
    ws_ext_sales_price        decimal(7,2)                  ,
    ws_ext_wholesale_cost     decimal(7,2)                  ,
    ws_ext_list_price         decimal(7,2)                  ,
    ws_ext_tax                decimal(7,2)                  ,
    ws_coupon_amt             decimal(7,2)                  ,
    ws_ext_ship_cost          decimal(7,2)                  ,
    ws_net_paid               decimal(7,2)                  ,
    ws_net_paid_inc_tax       decimal(7,2)                  ,
    ws_net_paid_inc_ship      decimal(7,2)                  ,
    ws_net_paid_inc_ship_tax  decimal(7,2)                  ,
    ws_net_profit             decimal(7,2)
)
partitioned by (ws_sold_date_sk int)
stored as ORC;

insert overwrite table web_sales partition (ws_sold_date_sk)
select
    ws.ws_sold_time_sk, ws.ws_ship_date_sk, ws.ws_item_sk,
    ws.ws_bill_customer_sk, ws.ws_bill_cdemo_sk, ws.ws_bill_hdemo_sk,
    ws.ws_bill_addr_sk, ws.ws_ship_customer_sk, ws.ws_ship_cdemo_sk,
    ws.ws_ship_hdemo_sk, ws.ws_ship_addr_sk, ws.ws_web_page_sk,
    ws.ws_web_site_sk, ws.ws_ship_mode_sk, ws.ws_warehouse_sk,
    ws.ws_promo_sk, ws.ws_order_number, ws.ws_quantity,
    ws.ws_wholesale_cost, ws.ws_list_price, ws.ws_sales_price,
    ws.ws_ext_discount_amt, ws.ws_ext_sales_price, ws.ws_ext_wholesale_cost,
    ws.ws_ext_list_price, ws.ws_ext_tax, ws.ws_coupon_amt,
    ws.ws_ext_ship_cost, ws.ws_net_paid, ws.ws_net_paid_inc_tax,
    ws.ws_net_paid_inc_ship, ws.ws_net_paid_inc_ship_tax, ws.ws_net_profit,
    ws.ws_sold_date_sk
from tpcds_1000_text.web_sales ws;

drop table if exists web_site;
create external table web_site
stored as ORC
as select * from tpcds_1000_text.web_site;

!sh echo FINISH EXECUTE etl tpcds.realschema convert;
!sh date +%s.%N;

!sh echo START EXECUTE etl tpcds.realschema stats;
!sh date +%s.%N;

analyze table call_center compute statistics;
analyze table catalog_page compute statistics;
analyze table catalog_returns compute statistics;
analyze table catalog_sales compute statistics;
analyze table customer compute statistics;
analyze table customer_address compute statistics;
analyze table customer_demographics compute statistics;
analyze table date_dim compute statistics;
analyze table household_demographics compute statistics;
analyze table income_band compute statistics;
analyze table inventory compute statistics;
analyze table item compute statistics;
analyze table promotion compute statistics;
analyze table reason compute statistics;
analyze table ship_mode compute statistics;
analyze table store compute statistics;
analyze table store_returns compute statistics;
analyze table store_sales compute statistics;
analyze table time_dim compute statistics;
analyze table warehouse compute statistics;
analyze table web_page compute statistics;
analyze table web_returns compute statistics;
analyze table web_sales compute statistics;
analyze table web_site compute statistics;
