CLASS /dmo/cl_fe_travel_generator DEFINITION

**************************************************************************
**
** Welcome to the SAP Fiori elements travel exercise generator!
**
** For exercises which focus on SAP Fiori elements and not the creation of
** an OData service, this generator was developed. It creates all the
** required RAP development artifacts for a travel scenario. You can then
** use this OData service and enhance its metadata extensions.
** However, if you’re interested in how to build such an OData service
** from scratch using RAP, check out the openSAP course "Building Apps
** with the ABAP RESTful Application Programming Model".
**
** Instructions:
**
** 1. Make sure the "Console" view is shown. If you can't see it, you can
**    open it using "Window" -> "Show View" -> "Other" -> "Console".
**
** 2. Right-click in this window and choose:
**    "Run As" -> "ABAP Application (Console)"
**    That takes a little over a minute.
**
** 3. When the generation finished your personal package name will be
**    printed to the "Console" view. It's important to note down your
**    package name!
**
** 4. In the "Project Explorer" right click on "Favorite Packages" and
**    click on "Add Package...". Enter your personal package name
**    (ZFE_TRAVEL_######) and click OK.
**
** 5. Have fun with the exercise! :)
**
**************************************************************************


  PUBLIC
  INHERITING FROM cl_xco_cp_adt_simple_classrun
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.

  PROTECTED SECTION.
    METHODS main REDEFINITION.

  PRIVATE SECTION.
    CONSTANTS:
      co_prefix         TYPE string         VALUE 'ZFE_TRAVEL_',
      co_zlocal_package TYPE sxco_package   VALUE 'ZLOCAL'.

    DATA package_name           TYPE sxco_package .
    DATA unique_suffix          TYPE string.
    DATA dev_system_environment TYPE REF TO if_xco_cp_gen_env_dev_system.
    DATA transport              TYPE sxco_transport .
    DATA table_name_root        TYPE sxco_dbt_object_name.
    DATA table_name_child       TYPE sxco_dbt_object_name.
    DATA table_name_status      TYPE sxco_dbt_object_name.
    DATA table_name_carrier     TYPE sxco_dbt_object_name.
    DATA table_name_connection  TYPE sxco_dbt_object_name.
    DATA table_name_flight      TYPE sxco_dbt_object_name.
    DATA draft_table_name_root  TYPE sxco_dbt_object_name.
    DATA draft_table_name_child TYPE sxco_dbt_object_name.
    DATA i_view_name_status     TYPE sxco_cds_object_name.
    DATA i_view_name_carrier    TYPE sxco_cds_object_name.
    DATA i_view_name_connection TYPE sxco_cds_object_name.
    DATA i_view_name_flight     TYPE sxco_cds_object_name.
    DATA i_view_name_a_travel   TYPE sxco_cds_object_name.
    DATA i_view_name_a_booking  TYPE sxco_cds_object_name.
    DATA c_view_name_a_booking  TYPE sxco_cds_object_name.
    DATA sqlviewname_a_travel   TYPE sxco_cds_object_name.
    DATA sqlviewname_a_booking  TYPE sxco_cds_object_name.
    DATA srv_definition_analytics TYPE sxco_cds_object_name.
    DATA srv_binding_analytics  TYPE sxco_cds_object_name.
    DATA create_mde_files       TYPE abap_bool.
    DATA data_generator_class_name TYPE sxco_ad_object_name.

    TYPES: BEGIN OF t_table_fields,
             field                  TYPE sxco_ad_field_name,
             is_key                 TYPE abap_bool,
             not_null               TYPE abap_bool,
             currencyCode           TYPE sxco_cds_field_name,
             unitOfMeasure          TYPE sxco_cds_field_name,
             data_element           TYPE sxco_ad_object_name,
             built_in_type          TYPE cl_xco_ad_built_in_type=>tv_type,
             built_in_type_length   TYPE cl_xco_ad_built_in_type=>tv_length,
             built_in_type_decimals TYPE cl_xco_ad_built_in_type=>tv_decimals,
           END OF t_table_fields.

    TYPES: tt_fields TYPE STANDARD TABLE OF t_table_fields WITH KEY field.

    METHODS get_unique_suffix
      IMPORTING
        VALUE(s_prefix)        TYPE string
      RETURNING
        VALUE(s_unique_suffix) TYPE string.

    METHODS create_transport
      RETURNING
        VALUE(lo_transport) TYPE sxco_transport.

    METHODS create_package
      IMPORTING
        VALUE(lo_transport) TYPE sxco_transport.

    METHODS generate_table  IMPORTING io_put_operation        TYPE REF TO if_xco_cp_gen_d_o_put
                                      table_fields            TYPE tt_fields
                                      table_name              TYPE sxco_dbt_object_name
                                      table_short_description TYPE if_xco_cp_gen_tabl_dbt_s_form=>tv_short_description.

    METHODS get_root_table_fields RETURNING VALUE(root_table_fields) TYPE tt_fields.

    METHODS get_child_table_fields RETURNING VALUE(child_table_fields) TYPE tt_fields.

    METHODS get_status_table_fields RETURNING VALUE(status_table_fields) TYPE tt_fields.
    METHODS generate_status_i_view IMPORTING io_put_operation TYPE REF TO if_xco_cp_gen_d_o_put.

    METHODS get_carrier_table_fields RETURNING VALUE(carrier_table_fields) TYPE tt_fields.
    METHODS generate_carrier_i_view IMPORTING io_put_operation TYPE REF TO if_xco_cp_gen_d_o_put.

    METHODS get_connection_table_fields RETURNING VALUE(connection_table_fields) TYPE tt_fields.
    METHODS generate_connection_i_view IMPORTING io_put_operation TYPE REF TO if_xco_cp_gen_d_o_put.

    METHODS get_flight_table_fields RETURNING VALUE(flight_table_fields) TYPE tt_fields.
    METHODS generate_flight_i_view IMPORTING io_put_operation TYPE REF TO if_xco_cp_gen_d_o_put.

    METHODS generate_data_generator_class IMPORTING io_put_operation    TYPE REF TO if_xco_cp_gen_d_o_put
                                                    VALUE(lo_transport) TYPE sxco_transport.

    METHODS release_data_generator_class IMPORTING VALUE(lo_transport) TYPE sxco_transport.



    METHODS generate_analytics_service IMPORTING io_put_operation1 TYPE REF TO if_xco_cp_gen_d_o_put
                                                 io_put_operation2 TYPE REF TO if_xco_cp_gen_d_o_put.
    METHODS get_json_string RETURNING VALUE(json_string) TYPE string.

    METHODS get_json_string_status RETURNING VALUE(json_string_status) TYPE string.

ENDCLASS.



CLASS /DMO/CL_FE_TRAVEL_GENERATOR IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).

    unique_suffix          = get_unique_suffix( co_prefix ).
    package_name           = co_prefix && unique_suffix. " your package name

    table_name_root        = |zfe_atrav_{ unique_suffix }|.
    table_name_child       = |zfe_abook_{ unique_suffix }|.
    table_name_status      = |zfe_astat_{ unique_suffix }|.
    table_name_carrier     = |zfe_acarr_{ unique_suffix }|.
    table_name_connection  = |zfe_aconn_{ unique_suffix }|.
    table_name_flight      = |zfe_aflig_{ unique_suffix }|.
    draft_table_name_root  = |zfe_dtrav_{ unique_suffix }|.
    draft_table_name_child = |zfe_dbook_{ unique_suffix }|.
    i_view_name_status     = |zi_fe_stat_{ unique_suffix }|.
    i_view_name_carrier    = |zi_fe_carr_{ unique_suffix }|.
    i_view_name_connection = |zi_fe_conn_{ unique_suffix }|.
    i_view_name_flight     = |zi_fe_flig_{ unique_suffix }|.
    i_view_name_a_booking  = |zi_fe_booking_analytics_{ unique_suffix }|.
    i_view_name_a_travel   = |zi_fe_travel_analytics_{ unique_suffix }|.
    c_view_name_a_booking  = |zc_fe_booking_analytics_{ unique_suffix }|.
    srv_definition_analytics = |zfe_booking_analytics_{ unique_suffix }|.
    srv_binding_analytics  = |zui_fe_booking_{ unique_suffix }_o2|.
    sqlviewname_a_travel   = |ZIFETRVANA{ unique_suffix }|.
    sqlviewname_a_booking  = |ZIFEBOKANA{ unique_suffix }|.
    data_generator_class_name = |ZFE_DATA_GENERATOR_{ unique_suffix }|.
    create_mde_files       = abap_false.
  ENDMETHOD.


  METHOD generate_data_generator_class.

    DATA(lo_specification) = io_put_operation->for-clas->add_object(  data_generator_class_name
                                  )->set_package( package_name
                                  )->create_form_specification( ).
    lo_specification->set_short_description( |This class generates the test data| ).

    lo_specification->set_short_description( 'Data generator class' ).
    lo_specification->definition->add_interface( 'if_oo_adt_classrun' ).
    lo_specification->implementation->add_method( |if_oo_adt_classrun~main|
      )->set_source( VALUE #(
     ( |    INSERT ('{ table_name_root }') FROM ( | )
( |        SELECT | )
( |          FROM /dmo/travel | )
( |          FIELDS | )
( |            uuid(  )      AS travel_uuid           , | )
( |            travel_id     AS travel_id             , | )
( |            agency_id     AS agency_id             , | )
( |            customer_id   AS customer_id           , | )
( |            begin_date    AS begin_date            , | )
( |            end_date      AS end_date              , | )
( |            booking_fee   AS booking_fee           , | )
( |            total_price   AS total_price           , | )
( |            currency_code AS currency_code         , | )
( |            description   AS description           , | )
( |            CASE status | )
( |              WHEN 'B' THEN 'A'   " accepted | )
( |              WHEN 'X' THEN 'X'   " cancelled | )
( |              ELSE 'O'            " open | )
( |            END           AS overall_status        , | )
( |            createdby     AS created_by            , | )
( |            createdat     AS created_at            , | )
( |            lastchangedby AS last_changed_by       , | )
( |            lastchangedat AS last_changed_at       , | )
( |            lastchangedat AS local_last_changed_at | )
( |            ORDER BY travel_id | )
( |      ). | )
( |    COMMIT WORK. | )
( | | )
( |    " define FROM clause dynamically | )
( |    DATA: dyn_table_name TYPE string. | )
( |    dyn_table_name = \| /dmo/booking    AS booking  \| | )
( |                 && \| JOIN  \{ '{ table_name_root }' \} AS z \| | )
( |                 && \| ON   booking~travel_id = z~travel_id \|. | )
( | | )
( |    " insert booking demo data | )
( |    INSERT ('{ table_name_child }') FROM ( | )
( |        SELECT | )
( |          FROM (dyn_table_name) | )
( |          FIELDS | )
( |            uuid( )                 AS booking_uuid          , | )
( |            z~travel_uuid           AS travel_uuid           , | )
( |            booking~booking_id      AS booking_id            , | )
( |            booking~booking_date    AS booking_date          , | )
( |            booking~customer_id     AS customer_id           , | )
( |            booking~carrier_id      AS carrier_id            , | )
( |            booking~connection_id   AS connection_id         , | )
( |            booking~flight_date     AS flight_date           , | )
( |            booking~flight_price    AS flight_price          , | )
( |            booking~currency_code   AS currency_code         , | )
( |            z~created_by            AS created_by            , | )
( |            z~last_changed_by       AS last_changed_by       , | )
( |            z~last_changed_at       AS local_last_changed_by | )
( |      ). | )
( |    COMMIT WORK. | )
( | | )
( |*   We overwrite the existing airlines with ours | )
( |    UPDATE ('{ table_name_child }') SET carrier_id = 'SW' WHERE carrier_id NOT IN ( 'AA', 'AZ', 'LH', 'JL' ). | )
( |    UPDATE ('{ table_name_child }') SET carrier_id = 'GA' WHERE carrier_id = 'AA'. | )
( |    UPDATE ('{ table_name_child }') SET carrier_id = 'FA' WHERE carrier_id = 'AZ'. | )
( |    UPDATE ('{ table_name_child }') SET carrier_id = 'EA' WHERE carrier_id = 'LH'. | )
( |    UPDATE ('{ table_name_child }') SET carrier_id = 'OC' WHERE carrier_id = 'JL'. | )
( |    COMMIT WORK. | )
( | | )
( |    " Travel Status Texts | )
( |    TYPES: BEGIN OF t_status_fields, | )
( |             client             TYPE mandt, | )
( |             travel_status_id   TYPE /dmo/overall_status, | )
( |             travel_status_text TYPE /dmo/description, | )
( |           END OF t_status_fields. | )
( |    TYPES: tt_status TYPE STANDARD TABLE OF t_status_fields WITH KEY travel_status_id. | )
( | | )
( |    DATA status_itab TYPE tt_status. | )
( | | )
( |    status_itab = VALUE tt_status( | )
( |      ( travel_status_id = 'O' travel_status_text = 'Open' ) | )
( |      ( travel_status_id = 'A' travel_status_text = 'Accepted' ) | )
( |      ( travel_status_id = 'X' travel_status_text = 'Rejected' ) | )
( |    ). | )
( |*   insert the new table entries | )
( |    INSERT ('{ table_name_status }') FROM TABLE @status_itab. | )
( |    COMMIT WORK. | )
( | | )
( | | )
( |    " Carrier | )
( |    TYPES: BEGIN OF t_carrier_fields, | )
( |             client          TYPE mandt, | )
( |             carrier_id      TYPE /dmo/carrier_id, | )
( |             name            TYPE /dmo/carrier_name, | )
( |             carrier_pic_url TYPE /dmo/carrier_pic, | )
( |             currency_code   TYPE /dmo/currency_code, | )
( |           END OF t_carrier_fields. | )
( |    TYPES: tt_carrier TYPE STANDARD TABLE OF t_carrier_fields WITH KEY carrier_id. | )
( | | )
( |    DATA carrier_itab TYPE tt_carrier. | )
( | | )
( |*   Carrier tab entries | )
( |    carrier_itab = VALUE tt_carrier( | )
( |      ( carrier_id = 'GA' name = 'Green Albatros' carrier_pic_url = 'https://raw.githubusercontent.com/SAP-samples/fiori-elements-opensap/main/week1/images/airlines/Green-Albatross-logo.png' currency_code = 'EUR') | )
( |      ( carrier_id = 'FA' name = 'Fly Africa' carrier_pic_url = 'https://raw.githubusercontent.com/SAP-samples/fiori-elements-opensap/main/week1/images/airlines/Fly-Africa-logo.png' currency_code = 'EUR') | )
( |      ( carrier_id = 'EA' name = 'European Airlines' carrier_pic_url = 'https://raw.githubusercontent.com/SAP-samples/fiori-elements-opensap/main/week1/images/airlines/European-Airlines-logo.png' currency_code = 'EUR') | )
( |      ( carrier_id = 'OC' name = 'Oceania' carrier_pic_url = 'https://raw.githubusercontent.com/SAP-samples/fiori-elements-opensap/main/week1/images/airlines/Oceania-logo.png' currency_code = 'EUR') | )
( |      ( carrier_id = 'SW' name = 'Sunset Wings' carrier_pic_url = 'https://raw.githubusercontent.com/SAP-samples/fiori-elements-opensap/main/week1/images/airlines/Sunset-Wings-logo.png' currency_code = 'EUR') | )
( |    ). | )
( | | )
( |*   insert the new table entries | )
( |    INSERT ('{ table_name_carrier }') FROM TABLE @carrier_itab. | )
( |    COMMIT WORK. | )
( | | )
( |    " insert connection demo data | )
( |    INSERT ('{ table_name_connection }') FROM ( | )
( |        SELECT | )
( |          FROM /dmo/connection | )
( |          FIELDS | )
( |            carrier_id, | )
( |            connection_id, | )
( |            airport_from_id, | )
( |            airport_to_id, | )
( |            departure_time, | )
( |            arrival_time, | )
( |            distance, | )
( |            distance_unit | )
( |    ). | )
( |    COMMIT WORK. | )
( | | )
( |*   We overwrite the existing airlines with ours | )
( |    UPDATE ('{ table_name_connection }') SET carrier_id = 'SW' WHERE carrier_id NOT IN ( 'AA', 'AZ', 'LH', 'JL' ). | )
( |    UPDATE ('{ table_name_connection }') SET carrier_id = 'GA' WHERE carrier_id = 'AA'. | )
( |    UPDATE ('{ table_name_connection }') SET carrier_id = 'FA' WHERE carrier_id = 'AZ'. | )
( |    UPDATE ('{ table_name_connection }') SET carrier_id = 'EA' WHERE carrier_id = 'LH'. | )
( |    UPDATE ('{ table_name_connection }') SET carrier_id = 'OC' WHERE carrier_id = 'JL'. | )
( |    COMMIT WORK. | )
( | | )
( |    " insert flight demo data | )
( |    INSERT ('{ table_name_flight }') FROM ( | )
( |      SELECT FROM /dmo/flight FIELDS | )
( |        " client | )
( |        carrier_id, | )
( |        connection_id, | )
( |        flight_date, | )
( |        price, | )
( |        currency_code, | )
( |        plane_type_id, | )
( |        seats_max, | )
( |        seats_occupied | )
( |    ). | )
( |    COMMIT WORK. | )
( | | )
( |*   We overwrite the existing airlines with ours | )
( |    UPDATE ('{ table_name_flight }') SET carrier_id = 'SW' WHERE carrier_id NOT IN ( 'AA', 'AZ', 'LH', 'JL' ). | )
( |    UPDATE ('{ table_name_flight }') SET carrier_id = 'GA' WHERE carrier_id = 'AA'. | )
( |    UPDATE ('{ table_name_flight }') SET carrier_id = 'FA' WHERE carrier_id = 'AZ'. | )
( |    UPDATE ('{ table_name_flight }') SET carrier_id = 'EA' WHERE carrier_id = 'LH'. | )
( |    UPDATE ('{ table_name_flight }') SET carrier_id = 'OC' WHERE carrier_id = 'JL'. | )
( |    COMMIT WORK. | )
( | | )
( |*   For simplicity reasons we only use one currency (EUR) | )
( |    UPDATE ('{ table_name_child }') SET flight_price = division( flight_price, 130, 2 )  where currency_code = 'JPY'. | )
( |    UPDATE ('{ table_name_root }') SET booking_fee = division( booking_fee, 130, 2 )  where currency_code = 'JPY'. | )
( |    UPDATE ('{ table_name_root }') SET total_price = division( total_price, 130, 2 )  where currency_code = 'JPY'. | )
( |    UPDATE ('{ table_name_child }') SET flight_price = division( flight_price, 2, 2 )  where currency_code = 'SGD'. | )
( |    UPDATE ('{ table_name_root }') SET booking_fee = division( booking_fee, 2, 2 )  where currency_code = 'SGD'. | )
( |    UPDATE ('{ table_name_root }') SET total_price = division( total_price, 2, 2 )  where currency_code = 'SGD'. | )
( |    UPDATE ('{ table_name_root }') SET currency_code = 'EUR'. | )
( |    UPDATE ('{ table_name_child }') SET currency_code = 'EUR'. | )
    ) ).

  ENDMETHOD.


  METHOD main.
    out->write( | SAP Fiori elements exercise generator | ).
    out->write( | ------------------------------------- | ).
    " to upper
    package_name  = to_upper( package_name ).
    unique_suffix = to_upper( unique_suffix ).

    "create transport
    transport = create_transport(  ).

    "create package
    create_package( transport ).
    out->write( | The following package got created for you and includes everything you need: { package_name } | ).
    out->write( | In the "Project Explorer" right click on "Favorite Packages" and click on "Add Package...". Enter "{ package_name }" and click OK. | ).

    dev_system_environment     = xco_cp_generation=>environment->dev_system( transport ).

    DATA(json_string)              = get_json_string(  ).            " get json document
    DATA(root_table_fields)        = get_root_table_fields(  ).
    DATA(lo_objects_put_operation) = dev_system_environment->create_put_operation( ).

    generate_table(
      EXPORTING
        io_put_operation        = lo_objects_put_operation
        table_fields            = root_table_fields
        table_name              = table_name_root
        table_short_description = 'Travel persistence for Travel scenario'
    ).

    IF table_name_child IS NOT INITIAL.
      DATA(child_table_fields)  = get_child_table_fields(  ).
      generate_table(
        EXPORTING
          io_put_operation        = lo_objects_put_operation
          table_fields            = child_table_fields
          table_name              = table_name_child
          table_short_description = 'Booking persistence for Travel scenario'
      ).
    ENDIF.

    DATA(status_table_fields)  = get_status_table_fields(  ).
    generate_table(
      EXPORTING
        io_put_operation        = lo_objects_put_operation
        table_fields            = status_table_fields
        table_name              = table_name_status
        table_short_description = 'Status Description persistence for Travel scenario'
    ).
    generate_status_i_view(
      EXPORTING
        io_put_operation        = lo_objects_put_operation
    ).

    DATA(carrier_table_fields)  = get_carrier_table_fields(  ).
    generate_table(
      EXPORTING
        io_put_operation        = lo_objects_put_operation
        table_fields            = carrier_table_fields
        table_name              = table_name_carrier
        table_short_description = 'Carrier persistence for Travel scenario'
    ).
    generate_carrier_i_view(
      EXPORTING
        io_put_operation        = lo_objects_put_operation
    ).

    DATA(connection_table_fields)  = get_connection_table_fields(  ).
    generate_table(
      EXPORTING
        io_put_operation        = lo_objects_put_operation
        table_fields            = connection_table_fields
        table_name              = table_name_connection
        table_short_description = 'Connection persistence for Travel scenario'
    ).
    generate_connection_i_view(
      EXPORTING
        io_put_operation        = lo_objects_put_operation
    ).

    DATA(flight_table_fields)  = get_flight_table_fields(  ).
    generate_table(
      EXPORTING
        io_put_operation        = lo_objects_put_operation
        table_fields            = flight_table_fields
        table_name              = table_name_flight
        table_short_description = 'Flight persistence for Travel scenario'
    ).
    generate_flight_i_view(
      EXPORTING
        io_put_operation        = lo_objects_put_operation
    ).

    DATA(lo_result) = lo_objects_put_operation->execute( ).

    " handle findings
    DATA(lo_findings) = lo_result->findings.
    DATA(lt_findings) = lo_findings->get( ).
    IF lt_findings IS NOT INITIAL.
      out->write( lt_findings ).
    ENDIF.

*   Create data generator class
    lo_objects_put_operation = dev_system_environment->create_put_operation( ).
    generate_data_generator_class(
      EXPORTING
        io_put_operation       = lo_objects_put_operation
        lo_transport            = transport
    ).
    lo_result = lo_objects_put_operation->execute( ).
    " handle findings
    lo_findings = lo_result->findings.
    lt_findings = lo_findings->get( ).
    IF lt_findings IS NOT INITIAL.
      out->write( lt_findings ).
    ENDIF.

    release_data_generator_class(
        EXPORTING
            lo_transport            = transport
    ).

    DATA lo_object TYPE REF TO if_oo_adt_classrun.
    CREATE OBJECT lo_object TYPE (data_generator_class_name).
    lo_object->main(
        EXPORTING out = out->plain
    ).

    DATA(rap_bo_generator) = NEW /dmo/cl_rap_generator( json_string ).
    DATA(lt_todos)         = rap_bo_generator->generate_bo(  ).

    " handle findings
    lo_findings = lo_result->findings.
    lt_findings = lo_findings->get( ).
    IF lt_findings IS NOT INITIAL.
      out->write( lt_findings ).
    ENDIF.

*    Delete mde files to start with annotations from scratch
    IF create_mde_files = abap_false.
      DATA mo_environment TYPE REF TO if_xco_cp_gen_env_dev_system.
      DATA lv_del_transport   TYPE sxco_transport.
      lv_del_transport = rap_bo_generator->root_node->transport_request.


      IF lv_del_transport IS INITIAL.
        DATA(cts_obj) = xco_cp_abap_repository=>object->for(
        EXPORTING
        iv_type = 'DDLX'
        iv_name = to_upper( rap_bo_generator->root_node->rap_node_objects-meta_data_extension )
        )->if_xco_cts_changeable~get_object( ).
        lv_del_transport = cts_obj->get_lock( )->get_transport( ).
        lv_del_transport = xco_cp_cts=>transport->for( lv_del_transport )->get_request( )->value.
      ENDIF.

      mo_environment = xco_cp_generation=>environment->dev_system( lv_del_transport ).
      DATA(lo_delete_operation) = mo_environment->for-ddlx->create_delete_operation( ).
      lo_delete_operation->add_object( rap_bo_generator->root_node->rap_node_objects-meta_data_extension ).
      LOOP AT rap_bo_generator->root_node->all_childnodes INTO DATA(ls_childnode).
        lo_delete_operation->add_object( ls_childnode->rap_node_objects-meta_data_extension ).
      ENDLOOP.
      lo_delete_operation->execute( ).
    ENDIF.

*   Create artifacts for analytics
    DATA(lo_objects_put_op_analytics1) = dev_system_environment->create_put_operation( ).
    DATA(lo_objects_put_op_analytics2) = dev_system_environment->create_put_operation( ).
    generate_analytics_service(
      EXPORTING
        io_put_operation1        = lo_objects_put_op_analytics1
        io_put_operation2        = lo_objects_put_op_analytics2
    ).
    DATA(lo_result_alp) = lo_objects_put_op_analytics1->execute( ).
    lo_findings = lo_result->findings.
    lt_findings = lo_findings->get( ).
    IF lt_findings IS NOT INITIAL.
      out->write( lt_findings ).
    ENDIF.

    lo_result_alp = lo_objects_put_op_analytics2->execute( ).
    lo_findings = lo_result->findings.
    lt_findings = lo_findings->get( ).
    IF lt_findings IS NOT INITIAL.
      out->write( lt_findings ).
    ENDIF.

    out->write( | Enjoy your SAP Fiori elements exercise :) | ).
  ENDMETHOD.


  METHOD create_transport.
    DATA(ls_package) = xco_cp_abap_repository=>package->for( co_zlocal_package )->read( ).
    DATA(lv_transport_layer) = ls_package-property-transport_layer->value.
    DATA(lv_transport_target) = ls_package-property-transport_layer->get_transport_target( )->value.
    DATA(lo_transport_request) = xco_cp_cts=>transports->workbench( lv_transport_target )->create_request( 'Generated FE tutorial transport request' ).

    lo_transport = lo_transport_request->value.
  ENDMETHOD.


  METHOD create_package.
    DATA(lo_put_operation) = xco_cp_generation=>environment->dev_system( lo_transport )->for-devc->create_put_operation( ).
    DATA(lo_specification) = lo_put_operation->add_object( package_name )->create_form_specification( ).
    lo_specification->set_short_description( 'FE tutorial package' ).
    lo_specification->properties->set_super_package( co_zlocal_package )->set_software_component( co_zlocal_package ).
    lo_put_operation->execute( ).
  ENDMETHOD.


  METHOD get_carrier_table_fields.
    carrier_table_fields = VALUE tt_fields(
                  ( field         = 'client'
                    data_element  = 'mandt'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'carrier_id'
                    data_element  = '/dmo/carrier_id'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'name'
                    data_element  = '/dmo/carrier_name' )
                  ( field         = 'carrier_pic_url'
                    data_element  = '/dmo/carrier_pic' )
                  ( field         = 'currency_code'
                    data_element  = '/dmo/currency_code' )
                    ).
  ENDMETHOD.


  METHOD get_json_string_status.
    " build the json document
    json_string_status ='{' && |\r\n|  &&
                         '  "implementationType": "unmanaged_semantic",' && |\r\n|  &&
                         '  "transactionalbehavior" : false,' && |\r\n|  &&
                         '  "publishservice" : false ,' && |\r\n|  &&
                         '  "namespace": "Z",' && |\r\n|  &&
                         |  "suffix": "_{ unique_suffix }",| && |\r\n|  &&
                         '  "prefix": "FE_",' && |\r\n|  &&
                         |  "package": "{ package_name }",| && |\r\n|  &&
                         '  "datasourcetype": "table",' && |\r\n|  &&
                         '  "draftenabled": false,' && |\r\n|  &&                            "draft
                         '  "bindingtype": "odata_v4_ui",' && |\r\n|  &&
                         '  "hierarchy": {' && |\r\n|  &&
                         '    "entityName": "Status",' && |\r\n|  &&
                         |    "dataSource": "{ table_name_status }",| && |\r\n|  &&
                         '    "objectId": "travel_status_id"' && |\r\n|  &&
                         '  }' && |\r\n|  &&
                        '}'.
  ENDMETHOD.


  METHOD get_root_table_fields.
    root_table_fields = VALUE tt_fields(
                  ( field         = 'client'
                    data_element  = 'mandt'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'travel_uuid'
                    data_element  = 'sysuuid_x16'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'travel_id'
                    data_element  = '/dmo/travel_id' )
                  ( field         = 'agency_id'
                    data_element  = '/dmo/agency_id' )
                  ( field         = 'customer_id'
                    data_element  = '/dmo/customer_id' )
                  ( field         = 'begin_date'
                    data_element  = '/dmo/begin_date' )
                  ( field         = 'end_date'
                    data_element  = '/dmo/end_date' )
                  ( field         = 'booking_fee'
                    data_element  = '/dmo/booking_fee'
                    currencycode  = 'currency_code' )
                  ( field         = 'total_price'
                    data_element  = '/dmo/total_price'
                    currencycode  = 'currency_code' )
                  ( field         = 'currency_code'
                    data_element  = '/dmo/currency_code' )
                  ( field         = 'description'
                    data_element  = '/dmo/description' )
                  ( field         = 'overall_status'
                    data_element  = '/dmo/overall_status' )
                  ( field         = 'created_by'
                    data_element  = 'syuname' )
                  ( field         = 'created_at'
                    data_element  = 'timestampl' )
                  ( field         = 'last_changed_by'
                    data_element  = 'syuname' )
                  ( field         = 'last_changed_at'
                    data_element  = 'timestampl' )
                  ( field         = 'local_last_changed_at '
                    data_element  = 'timestampl' )
                    ).
  ENDMETHOD.


  METHOD get_connection_table_fields.
    connection_table_fields = VALUE tt_fields(
                  ( field         = 'client'
                    data_element  = 'mandt'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'carrier_id'
                    data_element  = '/dmo/carrier_id'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'connection_id'
                    data_element  = '/dmo/connection_id'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'airport_from_id'
                    data_element  = '/dmo/airport_from_id' )
                  ( field         = 'airport_to_id'
                    data_element  = '/dmo/airport_to_id' )
                  ( field         = 'departure_time'
                    data_element  = '/dmo/flight_departure_time' )
                  ( field         = 'arrival_time'
                    data_element  = '/dmo/flight_arrival_time' )
                  ( field         = 'distance'
                    data_element  = '/dmo/flight_distance' )
                  ( field         = 'distance_unit'
                    data_element  = 'msehi' )
    ).
  ENDMETHOD.


  METHOD get_status_table_fields.
    status_table_fields = VALUE tt_fields(
                  ( field         = 'client'
                    data_element  = 'mandt'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'travel_status_id'
                    data_element  = '/dmo/overall_status'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'travel_status_text'
                    data_element  = '/dmo/description' )
                    ).
  ENDMETHOD.


  METHOD get_unique_suffix.
    DATA: li_counter(6)    TYPE n,
          ls_counter       TYPE string,
          ls_package_name  TYPE sxco_package,
          is_valid_package TYPE abap_bool.


    s_unique_suffix = ''.
    is_valid_package = abap_false.
    li_counter = 0.
    ls_counter = li_counter.
    ls_package_name = s_prefix && ls_counter.

    WHILE is_valid_package = abap_false.
      "check package name
      DATA(lo_package) = xco_cp_abap_repository=>object->devc->for( ls_package_name ).
      IF NOT lo_package->exists( ).
        is_valid_package = abap_true.
        s_unique_suffix = ls_counter.
      ENDIF.
      li_counter = li_counter + 1.
      ls_counter = li_counter.
      ls_package_name = s_prefix && ls_counter.
    ENDWHILE.
  ENDMETHOD.


  METHOD generate_table.

    DATA(lo_specification) = io_put_operation->for-tabl-for-database_table->add_object( table_name
              )->set_package( package_name
               )->create_form_specification( ).

    lo_specification->set_short_description( table_short_description ).

    DATA database_table_field  TYPE REF TO if_xco_gen_tabl_dbt_s_fo_field  .

    LOOP AT table_fields INTO DATA(table_field_line).
      database_table_field = lo_specification->add_field( table_field_line-field  ).

      IF table_field_line-is_key = abap_true.
        database_table_field->set_key_indicator( ).
      ENDIF.
      IF table_field_line-not_null = abap_true.
        database_table_field->set_not_null( ).
      ENDIF.
      IF table_field_line-currencycode IS NOT INITIAL.
        database_table_field->currency_quantity->set_reference_table( CONV #( to_upper( table_name ) ) )->set_reference_field( to_upper( table_field_line-currencycode ) ).
      ENDIF.
      IF table_field_line-unitofmeasure IS NOT INITIAL.
        database_table_field->currency_quantity->set_reference_table( CONV #( to_upper( table_name ) ) )->set_reference_field( to_upper( table_field_line-unitofmeasure ) ).
      ENDIF.
      IF table_field_line-data_element IS NOT INITIAL.
        database_table_field->set_type( xco_cp_abap_dictionary=>data_element( table_field_line-data_element ) ).
      ELSE.
        CASE  to_lower( table_field_line-built_in_type ).
          WHEN 'accp'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->accp ).
          WHEN 'clnt'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->clnt ).
          WHEN 'cuky'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->cuky ).
          WHEN 'dats'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->dats ).
          WHEN 'df16_raw'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->df16_raw ).
          WHEN 'df34_raw'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->df34_raw ).
          WHEN 'fltp'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->fltp ).
          WHEN 'int1'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->int1 ).
          WHEN 'int2'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->int2 ).
          WHEN 'int4'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->int4 ).
          WHEN 'int8'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->int8 ).
          WHEN 'lang'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->lang ).
          WHEN 'tims'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->tims ).
          WHEN 'char'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->char( table_field_line-built_in_type_length  ) ).
          WHEN 'curr'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->curr(
                                              iv_length   = table_field_line-built_in_type_length
                                              iv_decimals = table_field_line-built_in_type_decimals
                                            ) ).
          WHEN 'dec'  .
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->dec(
                                              iv_length   = table_field_line-built_in_type_length
                                              iv_decimals = table_field_line-built_in_type_decimals
                                            ) ).
          WHEN 'df16_dec'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->df16_dec(
                                              iv_length   = table_field_line-built_in_type_length
                                              iv_decimals = table_field_line-built_in_type_decimals
                                            ) ).
          WHEN 'df34_dec'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->df34_dec(
                                              iv_length   = table_field_line-built_in_type_length
                                              iv_decimals = table_field_line-built_in_type_decimals
                                            ) ).
          WHEN 'lchr' .
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->lchr( table_field_line-built_in_type_length  ) ).
          WHEN 'lraw'  .
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->lraw( table_field_line-built_in_type_length  ) ).
          WHEN 'numc'   .
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->numc( table_field_line-built_in_type_length  ) ).
          WHEN 'quan' .
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->quan(
                                              iv_length   = table_field_line-built_in_type_length
                                              iv_decimals = table_field_line-built_in_type_decimals
                                              ) ).
          WHEN 'raw'  .
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->raw( table_field_line-built_in_type_length  ) ).
          WHEN 'rawstring'.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->rawstring( table_field_line-built_in_type_length  ) ).
          WHEN 'sstring' .
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->sstring( table_field_line-built_in_type_length  ) ).
          WHEN 'string' .
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->string( table_field_line-built_in_type_length  ) ).
          WHEN 'unit'  .
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->unit( table_field_line-built_in_type_length  ) ).
          WHEN OTHERS.
            database_table_field->set_type( xco_cp_abap_dictionary=>built_in_type->for(
                                              iv_type     = to_upper( table_field_line-built_in_type )
                                              iv_length   = table_field_line-built_in_type_length
                                              iv_decimals = table_field_line-built_in_type_decimals
                                            ) ).
        ENDCASE.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_child_table_fields.
    child_table_fields = VALUE tt_fields(
                   ( field         = 'client'
                     data_element  = 'mandt'
                     is_key        = 'X'
                     not_null      = 'X' )
                   ( field         = 'booking_uuid'
                     data_element  = 'sysuuid_x16'
                     is_key        = 'X'
                     not_null      = 'X' )
                   ( field         = 'travel_uuid'
                     data_element  = 'sysuuid_x16'
                     not_null      = 'X' )
                   ( field         = 'booking_id'
                     data_element  = '/dmo/booking_id' )
                   ( field         = 'booking_date'
                     data_element  = '/dmo/booking_date' )
                   ( field         = 'customer_id'
                     data_element  = '/dmo/customer_id' )
                   ( field         = 'carrier_id'
                     data_element  = '/dmo/carrier_id' )
                   ( field         = 'connection_id'
                     data_element  = '/dmo/connection_id' )
                   ( field         = 'flight_date'
                     data_element  = '/dmo/flight_date' )
                   ( field         = 'flight_price'
                     data_element  = '/dmo/flight_price'
                     currencycode  = 'currency_code'  )
                   ( field         = 'currency_code'
                     data_element  = '/dmo/currency_code' )
                   ( field         = 'created_by'
                     data_element  = 'syuname' )
                   ( field         = 'last_changed_by'
                     data_element  = 'syuname' )
                   ( field         = 'local_last_changed_at '
                     data_element  = 'timestampl' )
                   ).
  ENDMETHOD.


  METHOD generate_connection_i_view.
    DATA: s_view_name_connection TYPE string,
          s_view_name_carrier    TYPE string.

    s_view_name_connection = i_view_name_connection.
    REPLACE ALL OCCURRENCES OF '_' IN s_view_name_connection WITH ''.
    s_view_name_carrier = i_view_name_carrier.

    DATA(lo_interface_specification) = io_put_operation->for-ddls->add_object( i_view_name_connection
      )->set_package( package_name
      )->create_form_specification( ).

    DATA(lo_view_entity) = lo_interface_specification->set_short_description( 'Connection view for Travel Scenario'
      )->add_view( ).
    lo_view_entity->data_source->set_entity( CONV #( table_name_connection ) )->set_alias( 'Connection' ).

    " View annotations.
    lo_view_entity->add_annotation( 'AbapCatalog.sqlViewName' )->value->build( )->add_string( s_view_name_connection ).
    lo_view_entity->add_annotation( 'AbapCatalog.compiler.compareFilter' )->value->build( )->add_boolean( abap_true ).
    lo_view_entity->add_annotation( 'AbapCatalog.preserveKey' )->value->build( )->add_boolean( abap_true ).
    lo_view_entity->add_annotation( 'AccessControl.authorizationCheck' )->value->build( )->add_enum( 'NOT_REQUIRED' ).
    lo_view_entity->add_annotation( 'EndUserText.label' )->value->build( )->add_string( 'Connection view entity' ).
    lo_view_entity->add_annotation( 'Search.searchable' )->value->build( )->add_boolean( abap_true ).

    " add associations
    DATA(lo_condition) = xco_cp_ddl=>field( 'AirlineID' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'AirlineID' )->of( '_Airline' ) ).
    lo_view_entity->add_association( i_view_name_carrier )->set_cardinality( xco_cp_cds=>cardinality->range( iv_min = 1 iv_max = 1 ) )->set_alias( '_Airline' )->set_condition( lo_condition ).

    " Add fields.
    DATA(lo_identifier) = lo_view_entity->add_field( xco_cp_ddl=>field( 'Connection.carrier_id' ) )->set_key( )->set_alias( 'AirlineID' ).
    lo_identifier->add_annotation( 'Search.defaultSearchElement' )->value->build( )->add_boolean( abap_true ).
    lo_identifier->add_annotation( 'Search.fuzzinessThreshold' )->value->build( )->add_number( '0.8' ).
    lo_identifier->add_annotation( 'ObjectModel.text.association' )->value->build( )->add_string( '_Airline' ).
    DATA(lo_valuehelpbuilder) = lo_identifier->add_annotation( 'Consumption.valueHelpDefinition' )->value->build( ).
    lo_valuehelpbuilder->begin_array(
                 )->begin_record(
                   )->add_member( 'entity'
                      )->begin_record(
                         )->add_member( 'name' )->add_string( s_view_name_carrier )->add_member( 'element' )->add_string( 'AirlineID'
                      )->end_record( ).
    lo_valuehelpbuilder->end_record( )->end_array( ).


    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Connection.connection_id' ) )->set_key( )->set_alias( 'ConnectionID' ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Connection.airport_from_id' ) )->set_alias( 'DepartureAirport' ).
    lo_valuehelpbuilder = lo_identifier->add_annotation( 'Consumption.valueHelpDefinition' )->value->build( ).
    lo_valuehelpbuilder->begin_array(
                 )->begin_record(
                   )->add_member( 'entity'
                      )->begin_record(
                         )->add_member( 'name' )->add_string( '/DMO/I_Airport' )->add_member( 'element' )->add_string( 'AirportID'
                      )->end_record( ).
    lo_valuehelpbuilder->end_record( )->end_array( ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Connection.airport_to_id' ) )->set_alias( 'DestinationAirport' ).
    lo_valuehelpbuilder = lo_identifier->add_annotation( 'Consumption.valueHelpDefinition' )->value->build( ).
    lo_valuehelpbuilder->begin_array(
                 )->begin_record(
                   )->add_member( 'entity'
                      )->begin_record(
                         )->add_member( 'name' )->add_string( '/DMO/I_Airport' )->add_member( 'element' )->add_string( 'AirportID'
                      )->end_record( ).
    lo_valuehelpbuilder->end_record( )->end_array( ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Connection.departure_time' ) )->set_alias( 'DepartureTime' ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Connection.arrival_time' ) )->set_alias( 'ArrivalTime' ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Connection.distance' ) )->set_alias( 'Distance' ).
    lo_identifier->add_annotation( 'Semantics.quantity.unitOfMeasure' )->value->build( )->add_string( 'DistanceUnit' ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Connection.distance_unit' ) )->set_alias( 'DistanceUnit' ).
    lo_identifier->add_annotation( 'Semantics.unitOfMeasure' )->value->build( )->add_boolean( abap_true ).

    " add association to publish
    lo_view_entity->add_field( xco_cp_ddl=>field( '_Airline' ) ).
  ENDMETHOD.


  METHOD get_flight_table_fields.
    flight_table_fields = VALUE tt_fields(
                  ( field         = 'client'
                    data_element  = 'mandt'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'carrier_id'
                    data_element  = '/dmo/carrier_id'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'connection_id'
                    data_element  = '/dmo/connection_id'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'flight_date'
                    data_element  = '/dmo/flight_date'
                    is_key        = 'X'
                    not_null      = 'X' )
                  ( field         = 'price'
                    data_element  = '/dmo/flight_price'
                    currencycode  = 'currency_code' )
                  ( field         = 'currency_code'
                    data_element  = '/dmo/currency_code' )
                  ( field         = 'plane_type_id'
                    data_element  = '/dmo/plane_type_id' )
                  ( field         = 'seats_max'
                    data_element  = '/dmo/plane_seats_max' )
                  ( field         = 'seats_occupied'
                    data_element  = '/dmo/plane_seats_occupied' )
    ).
  ENDMETHOD.


  METHOD generate_flight_i_view.
    DATA: s_view_name_connection TYPE string,
          s_view_name_carrier    TYPE string,
          s_view_name_flight     TYPE string.

    s_view_name_flight = i_view_name_flight.
    REPLACE ALL OCCURRENCES OF '_' IN s_view_name_flight WITH ''.
    s_view_name_connection = i_view_name_connection.
    s_view_name_carrier = i_view_name_carrier.

    DATA(lo_interface_specification) = io_put_operation->for-ddls->add_object( i_view_name_flight
      )->set_package( package_name
      )->create_form_specification( ).

    DATA(lo_view_entity) = lo_interface_specification->set_short_description( 'Flight view for Travel Scenario'
      )->add_view( ).
    lo_view_entity->data_source->set_entity( CONV #( table_name_flight ) )->set_alias( 'Flight' ).

    " View annotations.
    lo_view_entity->add_annotation( 'AbapCatalog.sqlViewName' )->value->build( )->add_string( s_view_name_flight ).
    lo_view_entity->add_annotation( 'AbapCatalog.compiler.compareFilter' )->value->build( )->add_boolean( abap_true ).
    lo_view_entity->add_annotation( 'AbapCatalog.preserveKey' )->value->build( )->add_boolean( abap_true ).
    lo_view_entity->add_annotation( 'AccessControl.authorizationCheck' )->value->build( )->add_enum( 'NOT_REQUIRED' ).
    lo_view_entity->add_annotation( 'EndUserText.label' )->value->build( )->add_string( 'Flight view entity' ).
    lo_view_entity->add_annotation( 'Search.searchable' )->value->build( )->add_boolean( abap_true ).

    " add associations
    DATA(lo_condition) = xco_cp_ddl=>field( 'AirlineID' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'AirlineID' )->of( '_Airline' ) ).
    lo_view_entity->add_association( i_view_name_carrier )->set_cardinality( xco_cp_cds=>cardinality->one )->set_alias( '_Airline' )->set_condition( lo_condition ).

    lo_condition = xco_cp_ddl=>field( 'ConnectionID' )->of_projection( )->eq( xco_cp_ddl=>field( 'ConnectionID' )->of( '_Connection' ) )->and(
      xco_cp_ddl=>field( 'AirlineID' )->of_projection( )->eq( xco_cp_ddl=>field( 'AirlineID' )->of( '_Connection' ) ) ).
    lo_view_entity->add_association( i_view_name_connection )->set_cardinality( xco_cp_cds=>cardinality->one )->set_alias( '_Connection' )->set_condition( lo_condition ).

    lo_condition = xco_cp_ddl=>field( 'CurrencyCode' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'Currency' )->of( '_Currency' ) ).
    lo_view_entity->add_association( 'I_Currency' )->set_cardinality( xco_cp_cds=>cardinality->zero_to_one )->set_alias( '_Currency' )->set_condition( lo_condition ).

    " Add fields.
    DATA(lo_identifier) = lo_view_entity->add_field( xco_cp_ddl=>field( 'Flight.carrier_id' ) )->set_key( )->set_alias( 'AirlineID' ).
    lo_identifier->add_annotation( 'Search.defaultSearchElement' )->value->build( )->add_boolean( abap_true ).
    lo_identifier->add_annotation( 'Search.fuzzinessThreshold' )->value->build( )->add_number( '0.8' ).
    lo_identifier->add_annotation( 'ObjectModel.text.association' )->value->build( )->add_string( '_Airline' ).
    DATA(lo_valuehelpbuilder) = lo_identifier->add_annotation( 'Consumption.valueHelpDefinition' )->value->build( ).
    lo_valuehelpbuilder->begin_array( )->begin_record(
        )->add_member( 'entity'
            )->begin_record(
                )->add_member( 'name' )->add_string( s_view_name_carrier )->add_member( 'element' )->add_string( 'AirlineID'
            )->end_record( ).
    lo_valuehelpbuilder->end_record( )->end_array( ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Flight.connection_id' ) )->set_key( )->set_alias( 'ConnectionID' ).
    lo_identifier->add_annotation( 'Search.defaultSearchElement' )->value->build( )->add_boolean( abap_true ).
    lo_identifier->add_annotation( 'Search.fuzzinessThreshold' )->value->build( )->add_number( '0.8' ).
    lo_valuehelpbuilder = lo_identifier->add_annotation( 'Consumption.valueHelpDefinition' )->value->build( ).
    lo_valuehelpbuilder->begin_array( )->begin_record(
        )->add_member( 'entity'
            )->begin_record(
                )->add_member( 'name' )->add_string( s_view_name_connection )->add_member( 'element' )->add_string( 'ConnectionID'
            )->end_record(
        )->add_member( 'additionalBinding'
            )->begin_array( )->begin_record(
                )->add_member( 'element' )->add_string( 'AirlineID' )->add_member( 'localElement' )->add_string( 'AirlineID'
            )->end_record( )->end_array( ).
    lo_valuehelpbuilder->end_record( )->end_array( ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Flight.flight_date' ) )->set_key( )->set_alias( 'FlightDate' ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Flight.price' ) )->set_alias( 'Price' ).
    lo_identifier->add_annotation( 'Semantics.amount.currencyCode' )->value->build( )->add_string( 'CurrencyCode' ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Flight.currency_code' ) )->set_alias( 'CurrencyCode' ).
    lo_identifier->add_annotation( 'Semantics.currencyCode' )->value->build( )->add_boolean( abap_true ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Flight.plane_type_id' ) )->set_alias( 'PlaneType' ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Flight.seats_max' ) )->set_alias( 'MaximumSeats' ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Flight.seats_occupied' ) )->set_alias( 'OccupiedSeats' ).

    " add association to publish
    lo_view_entity->add_field( xco_cp_ddl=>field( '_Airline' ) ).
    lo_view_entity->add_field( xco_cp_ddl=>field( '_Connection' ) ).
    lo_view_entity->add_field( xco_cp_ddl=>field( '_Currency' ) ).
  ENDMETHOD.


  METHOD get_json_string.
    " build the json document
    json_string ='{' && |\r\n|  &&
                 '  "implementationType": "managed_uuid",' && |\r\n|  &&
                 '  "transactionalbehavior" : true,' && |\r\n|  &&
                 '  "publishservice" : true ,' && |\r\n|  &&
                 |  "transportrequest": "{ transport }",| && |\r\n|  &&
                 '  "namespace": "Z",' && |\r\n|  &&
                 |  "suffix": "_{ unique_suffix }",| && |\r\n|  &&
                 '  "prefix": "FE_",' && |\r\n|  &&
                 |  "package": "{ package_name }",| && |\r\n|  &&
                 '  "datasourcetype": "table",' && |\r\n|  &&
                 '  "draftenabled": true,' && |\r\n|  &&                            "draft
                 '  "bindingtype": "odata_v4_ui",' && |\r\n|  &&
                 '  "hierarchy": {' && |\r\n|  &&
                 '    "entityName": "Travel",' && |\r\n|  &&
                 |    "dataSource": "{ table_name_root }",| && |\r\n|  &&
                 |    "drafttable": "{ draft_table_name_root }",| && |\r\n|  &&     "draft
                 '    "objectId": "travel_id",' && |\r\n|  &&
                 '    "uuid": "travel_uuid",' && |\r\n|  &&

                 " value help definitions
                 '    "valueHelps": [' && |\r\n|  &&
                 '      {' && |\r\n|  &&
                 '        "alias": "Agency",' && |\r\n|  &&
                 '        "name": "/DMO/I_Agency",' && |\r\n|  &&
                 '        "localElement": "AgencyID",' && |\r\n|  &&
                 '        "element": "AgencyID"' && |\r\n|  &&
                 '      },' && |\r\n|  &&
                 '      {' && |\r\n|  &&
                 '        "alias": "Currency",' && |\r\n|  &&
                 '        "name": "I_Currency",' && |\r\n|  &&
                 '        "localElement": "CurrencyCode",' && |\r\n|  &&
                 '        "element": "Currency"' && |\r\n|  &&
                 '      }' && |\r\n|  &&
                 '    ],' && |\r\n|  &&
                 '    "associations": [' && |\r\n|  &&
                 '      {' && |\r\n|  &&
                 '        "name": "_Agency",' && |\r\n|  &&
                 '        "target": "/DMO/I_Agency",' && |\r\n|  &&
                 '        "cardinality": "zero_to_one",' && |\r\n|  &&
                 '        "conditions": [' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "projectionField": "AgencyID",' && |\r\n|  &&
                 '            "associationField": "AgencyID"' && |\r\n|  &&
                 '          }' && |\r\n|  &&
                 '        ]' && |\r\n|  &&
                 '      },' && |\r\n|  &&
                 '      {' && |\r\n|  &&
                 '        "name": "_Currency",' && |\r\n|  &&
                 '        "target": "I_Currency",' && |\r\n|  &&
                 '        "cardinality": "zero_to_one",' && |\r\n|  &&
                 '        "conditions": [' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "projectionField": "CurrencyCode",' && |\r\n|  &&
                 '            "associationField": "Currency"' && |\r\n|  &&
                 '          }' && |\r\n|  &&
                 '        ]' && |\r\n|  &&
                 '      },' && |\r\n|  &&
                 '      {' && |\r\n|  &&
                 '        "name": "_Customer",' && |\r\n|  &&
                 '        "target": "/DMO/I_Customer",' && |\r\n|  &&
                 '        "cardinality": "zero_to_one",' && |\r\n|  &&
                 '        "conditions": [' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "projectionField": "CustomerID",' && |\r\n|  &&
                 '            "associationField": "CustomerID"' && |\r\n|  &&
                 '          }' && |\r\n|  &&
                 '        ]' && |\r\n|  &&
                 '      },' && |\r\n|  &&
                 '      {' && |\r\n|  &&
                 '        "name": "_TravelStatus",' && |\r\n|  &&
                 |        "target": "{ i_view_name_status }",| && |\r\n|  &&
                 '        "cardinality": "zero_to_one",' && |\r\n|  &&
                 '        "conditions": [' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "projectionField": "OverallStatus",' && |\r\n|  &&
                 '            "associationField": "TravelStatusId"' && |\r\n|  &&
                 '          }' && |\r\n|  &&
                 '        ]' && |\r\n|  &&
                 '      }' && |\r\n|  &&
                 '    ],' && |\r\n|  &&

                 " children
                 '    "children": [' && |\r\n|  &&
                 '      {' && |\r\n|  &&
                 '        "entityName": "Booking",' && |\r\n|  &&
                 |        "dataSource": "{ table_name_child }",| && |\r\n|  &&
                 |        "drafttable": "{ draft_table_name_child }",| && |\r\n|  &&     "draft
                 '        "objectId": "booking_id",' && |\r\n|  &&
                 '        "uuid": "booking_uuid",' && |\r\n|  &&
                 '        "parentUuid": "travel_uuid",' && |\r\n|  &&
                 '        "valueHelps": [' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "alias": "Flight",' && |\r\n|  &&
                 |            "name": "{ i_view_name_flight }",| && |\r\n|  &&
                 '            "localElement": "ConnectionID",' && |\r\n|  &&
                 '            "element": "ConnectionID",' && |\r\n|  &&
                 '            "additionalBinding": [' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "localElement": "FlightDate",' && |\r\n|  &&
                 '                "element": "FlightDate"' && |\r\n|  &&
                 '              },' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "localElement": "CarrierID",' && |\r\n|  &&
                 '                "element": "AirlineID"' && |\r\n|  &&
                 '              },' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "localElement": "FlightPrice",' && |\r\n|  &&
                 '                "element": "Price"' && |\r\n|  &&
                 '              },' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "localElement": "CurrencyCode",' && |\r\n|  &&
                 '                "element": "CurrencyCode"' && |\r\n|  &&
                 '              }' && |\r\n|  &&
                 '            ]' && |\r\n|  &&
                 '          },' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "alias": "Currency",' && |\r\n|  &&
                 '            "name": "I_Currency",' && |\r\n|  &&
                 '            "localElement": "CurrencyCode",' && |\r\n|  &&
                 '            "element": "Currency"' && |\r\n|  &&
                 '          },' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "alias": "Airline",' && |\r\n|  &&
                 |            "name": "{ i_view_name_carrier }",| && |\r\n|  &&
                 '            "localElement": "CarrierID",' && |\r\n|  &&
                 '            "element": "AirlineID"' && |\r\n|  &&
                 '          },' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "alias": "Customer",' && |\r\n|  &&
                 '            "name": "/DMO/I_Customer",' && |\r\n|  &&
                 '            "localElement": "CustomerID",' && |\r\n|  &&
                 '            "element": "CustomerID"' && |\r\n|  &&
                 '          }' && |\r\n|  &&
                 '        ],' && |\r\n|  &&
                 '        "associations": [' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "name": "_Connection",' && |\r\n|  &&
                 |            "target": "{ i_view_name_connection }",| && |\r\n|  &&
                 '            "cardinality": "one_to_one",' && |\r\n|  &&
                 '            "conditions": [' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "projectionField": "CarrierID",' && |\r\n|  &&
                 '                "associationField": "AirlineID"' && |\r\n|  &&
                 '              },' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "projectionField": "ConnectionID",' && |\r\n|  &&
                 '                "associationField": "ConnectionID"' && |\r\n|  &&
                 '              }' && |\r\n|  &&
                 '            ]' && |\r\n|  &&
                 '          },' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "name": "_Flight",' && |\r\n|  &&
                 |            "target": "{ i_view_name_flight }",| && |\r\n|  &&
                 '            "cardinality": "one_to_one",' && |\r\n|  &&
                 '            "conditions": [' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "projectionField": "CarrierID",' && |\r\n|  &&
                 '                "associationField": "AirlineID"' && |\r\n|  &&
                 '              },' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "projectionField": "ConnectionID",' && |\r\n|  &&
                 '                "associationField": "ConnectionID"' && |\r\n|  &&
                 '              },' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "projectionField": "FlightDate",' && |\r\n|  &&
                 '                "associationField": "FlightDate"' && |\r\n|  &&
                 '              }' && |\r\n|  &&
                 '            ]' && |\r\n|  &&
                 '          },' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "name": "_Carrier",' && |\r\n|  &&
                 |            "target": "{ i_view_name_carrier }",| && |\r\n|  &&
                 '            "cardinality": "one_to_one",' && |\r\n|  &&
                 '            "conditions": [' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "projectionField": "CarrierID",' && |\r\n|  &&
                 '                "associationField": "AirlineID"' && |\r\n|  &&
                 '              }' && |\r\n|  &&
                 '            ]' && |\r\n|  &&
                 '          },' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "name": "_Currency",' && |\r\n|  &&
                 '            "target": "I_Currency",' && |\r\n|  &&
                 '            "cardinality": "zero_to_one",' && |\r\n|  &&
                 '            "conditions": [' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "projectionField": "CurrencyCode",' && |\r\n|  &&
                 '                "associationField": "Currency"' && |\r\n|  &&
                 '              }' && |\r\n|  &&
                 '            ]' && |\r\n|  &&
                 '          },' && |\r\n|  &&
                 '          {' && |\r\n|  &&
                 '            "name": "_Customer",' && |\r\n|  &&
                 '            "target": "/DMO/I_Customer",' && |\r\n|  &&
                 '            "cardinality": "one_to_one",' && |\r\n|  &&
                 '            "conditions": [' && |\r\n|  &&
                 '              {' && |\r\n|  &&
                 '                "projectionField": "CustomerID",' && |\r\n|  &&
                 '                "associationField": "CustomerID"' && |\r\n|  &&
                 '              }' && |\r\n|  &&
                 '            ]' && |\r\n|  &&
                 '          }' && |\r\n|  &&
                 '        ]' && |\r\n|  &&
                 '      }' && |\r\n|  &&
                 '    ]' && |\r\n|  &&
                 '  }' && |\r\n|  &&
                 '}'.
  ENDMETHOD.


  METHOD generate_status_i_view.
    DATA(lo_interface_specification) = io_put_operation->for-ddls->add_object( i_view_name_status
      )->set_package( package_name
      )->create_form_specification( ).

    DATA(lo_view_entity) = lo_interface_specification->set_short_description( 'Status view for Travel Scenario'
      )->add_view( ).
    lo_view_entity->data_source->set_entity( CONV #( table_name_status ) )->set_alias( 'Status' ).

    " View annotations.
    DATA s_view_name TYPE string.
    s_view_name = i_view_name_status.
    REPLACE ALL OCCURRENCES OF '_' IN s_view_name WITH ''.

    lo_view_entity->add_annotation( 'AbapCatalog.sqlViewName' )->value->build( )->add_string( s_view_name ).
    lo_view_entity->add_annotation( 'AbapCatalog.compiler.compareFilter' )->value->build( )->add_boolean( abap_true ).
    lo_view_entity->add_annotation( 'AbapCatalog.preserveKey' )->value->build( )->add_boolean( abap_true ).
    lo_view_entity->add_annotation( 'AccessControl.authorizationCheck' )->value->build( )->add_enum( 'NOT_REQUIRED' ).
    lo_view_entity->add_annotation( 'EndUserText.label' )->value->build( )->add_string( 'Travel Status view entity' ).

    " Add fields.
    DATA(lo_identifier) = lo_view_entity->add_field( xco_cp_ddl=>field( 'Status.travel_status_id' ) )->set_key( )->set_alias( 'TravelStatusId' ).
    lo_identifier->add_annotation( 'UI.textArrangement' )->value->build( )->add_enum( 'TEXT_ONLY' ).
    lo_identifier->add_annotation( 'ObjectModel.text.element' )->value->build( )->begin_array( )->add_string( 'TravelStatusText' ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Status.travel_status_text' ) )->set_alias( 'TravelStatusText' ).
    lo_identifier->add_annotation( 'UI.hidden' )->value->build( )->add_boolean( abap_true ).
  ENDMETHOD.


  METHOD release_data_generator_class.

    DATA(lo_change_scenario) = xco_cp_cts=>transport->for( lo_transport ).
    DATA(lo_api_state) = xco_cp_ars=>api_state->released( VALUE #( ( xco_cp_ars=>visibility->sap_cloud_platform ) ) ).

    DATA(lo_data_element) = xco_cp_abap_repository=>object->clas->for( data_generator_class_name ).
    lo_data_element->set_api_state(
      io_change_scenario = lo_change_scenario
      io_api_state       = lo_api_state
    ).

  ENDMETHOD.


  METHOD generate_carrier_i_view.
    DATA(lo_interface_specification) = io_put_operation->for-ddls->add_object( i_view_name_carrier
      )->set_package( package_name
      )->create_form_specification( ).

    DATA(lo_view_entity) = lo_interface_specification->set_short_description( 'Carrier view for Travel Scenario'
      )->add_view( ).
    lo_view_entity->data_source->set_entity( CONV #( table_name_carrier ) )->set_alias( 'Airline' ).

    " View annotations.
    DATA s_view_name TYPE string.
    s_view_name = i_view_name_carrier.
    REPLACE ALL OCCURRENCES OF '_' IN s_view_name WITH ''.

    lo_view_entity->add_annotation( 'AbapCatalog.sqlViewName' )->value->build( )->add_string( s_view_name ).
    lo_view_entity->add_annotation( 'AbapCatalog.compiler.compareFilter' )->value->build( )->add_boolean( abap_true ).
    lo_view_entity->add_annotation( 'AbapCatalog.preserveKey' )->value->build( )->add_boolean( abap_true ).
    lo_view_entity->add_annotation( 'AccessControl.authorizationCheck' )->value->build( )->add_enum( 'NOT_REQUIRED' ).
    lo_view_entity->add_annotation( 'EndUserText.label' )->value->build( )->add_string( 'Carrier view entity' ).
    lo_view_entity->add_annotation( 'Search.searchable' )->value->build( )->add_boolean( abap_true ).

    " add associations
    DATA(lo_condition) = xco_cp_ddl=>field( 'CurrencyCode' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'Currency' )->of( '_Currency' ) ).
    lo_view_entity->add_association( 'I_Currency' )->set_cardinality( xco_cp_cds=>cardinality->zero_to_one )->set_alias( '_Currency' )->set_condition( lo_condition ).

    " Add fields.
    DATA(lo_identifier) = lo_view_entity->add_field( xco_cp_ddl=>field( 'Airline.carrier_id' ) )->set_key( )->set_alias( 'AirlineID' ).
    lo_identifier->add_annotation( 'Search.defaultSearchElement' )->value->build( )->add_boolean( abap_true ).
    lo_identifier->add_annotation( 'ObjectModel.text.element' )->value->build( )->begin_array( )->add_string( 'Name' ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Airline.name' ) )->set_alias( 'Name' ).
    lo_identifier->add_annotation( 'Search.defaultSearchElement' )->value->build( )->add_boolean( abap_true ).
    lo_identifier->add_annotation( 'Search.fuzzinessThreshold' )->value->build( )->add_number( '0.7' ).
    lo_identifier->add_annotation( 'Semantics.text' )->value->build( )->add_boolean( abap_true ).

    "ToDo: cast for pic_url
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Airline.carrier_pic_url' ) )->set_alias( 'AirlinePicURL' ).
    lo_identifier->add_annotation( 'Semantics.imageUrl' )->value->build( )->add_boolean( abap_true ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'Airline.currency_code' ) )->set_alias( 'CurrencyCode' ).
    lo_identifier->add_annotation( 'Semantics.currencyCode' )->value->build( )->add_boolean( abap_true ).

    " add association to publish
    lo_view_entity->add_field( xco_cp_ddl=>field( '_Currency' ) ).
  ENDMETHOD.


  METHOD generate_analytics_service.

*   Create travel i view
    DATA(lo_interface_spec_i_travel) = io_put_operation1->for-ddls->add_object( i_view_name_a_travel
      )->set_package( package_name
      )->create_form_specification( ).

    DATA(lo_view_entity_i_travel) = lo_interface_spec_i_travel->set_short_description( 'Travel view for Booking Analysis'
      )->add_view( ).
    lo_view_entity_i_travel->data_source->set_entity( CONV #( table_name_root ) )->set_alias( 'Travel' ).

    " View annotations.
    lo_view_entity_i_travel->add_annotation( 'AbapCatalog.sqlViewName' )->value->build( )->add_string( CONV #( sqlviewname_a_travel ) ).
    lo_view_entity_i_travel->add_annotation( 'AccessControl.authorizationCheck' )->value->build( )->add_enum( 'CHECK' ).
    lo_view_entity_i_travel->add_annotation( 'EndUserText.label' )->value->build( )->add_string( 'Travel view entity for booking analysis' ).
    lo_view_entity_i_travel->add_annotation( 'Metadata.allowExtensions' )->value->build( )->add_boolean( abap_true ).

    " add associations
    DATA(lo_condition_i_travel) = xco_cp_ddl=>field( 'AgencyID' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'AgencyID' )->of( '_Agency' ) ).
    lo_view_entity_i_travel->add_association( '/DMO/I_Agency' )->set_cardinality( xco_cp_cds=>cardinality->range( iv_min = 0 iv_max = 1 ) )->set_alias( '_Agency' )->set_condition( lo_condition_i_travel ).

    lo_condition_i_travel = xco_cp_ddl=>field( 'CustomerID' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'CustomerID' )->of( '_Customer' ) ).
    lo_view_entity_i_travel->add_association( '/DMO/I_Customer' )->set_cardinality( xco_cp_cds=>cardinality->range( iv_min = 0 iv_max = 1 ) )->set_alias( '_Customer' )->set_condition( lo_condition_i_travel ).

    " Add fields.
    DATA(lo_identifier_i_travel) = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'TRAVEL_UUID' ) )->set_key( )->set_alias( 'TravelUUID' ).

    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'TRAVEL_ID' ) )->set_alias( 'TravelID' ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'AGENCY_ID' ) )->set_alias( 'AgencyID' ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'CUSTOMER_ID' ) )->set_alias( 'CustomerID' ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'BEGIN_DATE' ) )->set_alias( 'BeginDate' ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'END_DATE' ) )->set_alias( 'EndDate' ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'BOOKING_FEE' ) )->set_alias( 'BookingFee' ).
    lo_identifier_i_travel->add_annotation( 'Semantics.amount.currencyCode' )->value->build( )->add_string( 'CurrencyCode' ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'TOTAL_PRICE' ) )->set_alias( 'TotalPrice' ).
    lo_identifier_i_travel->add_annotation( 'Semantics.amount.currencyCode' )->value->build( )->add_string( 'CurrencyCode' ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'CURRENCY_CODE' ) )->set_alias( 'CurrencyCode' ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'DESCRIPTION' ) )->set_alias( 'Description' ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'OVERALL_STATUS' ) )->set_alias( 'OverallStatus' ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'CREATED_BY' ) )->set_alias( 'CreatedBy' ).
    lo_identifier_i_travel->add_annotation( 'Semantics.user.createdBy' )->value->build( )->add_boolean( abap_true ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'CREATED_AT' ) )->set_alias( 'CreatedAt' ).
    lo_identifier_i_travel->add_annotation( 'Semantics.systemDateTime.createdAt' )->value->build( )->add_boolean( abap_true ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'LAST_CHANGED_BY' ) )->set_alias( 'LastChangedBy' ).
    lo_identifier_i_travel->add_annotation( 'Semantics.user.lastChangedBy' )->value->build( )->add_boolean( abap_true ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'LAST_CHANGED_AT' ) )->set_alias( 'LAST_CHANGED_AT' ).
    lo_identifier_i_travel->add_annotation( 'Semantics.systemDateTime.lastChangedAt' )->value->build( )->add_boolean( abap_true ).
    lo_identifier_i_travel = lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( 'LOCAL_LAST_CHANGED_AT' ) )->set_alias( 'LocalLastChangedAt' ).
    lo_identifier_i_travel->add_annotation( 'Semantics.systemDateTime.localInstanceLastChangedAt' )->value->build( )->add_boolean( abap_true ).

    " add association to publish
    lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( '_Agency' ) ).
    lo_view_entity_i_travel->add_field( xco_cp_ddl=>field( '_Customer' ) ).

*   Create booking i view
    DATA(lo_interface_spec_i_booking) = io_put_operation1->for-ddls->add_object( i_view_name_a_booking
      )->set_package( package_name
      )->create_form_specification( ).

    DATA(lo_view_entity_i_booking) = lo_interface_spec_i_booking->set_short_description( 'Booking view for Booking Analysis'
      )->add_view( ).
    lo_view_entity_i_booking->data_source->set_entity( CONV #( table_name_child ) )->set_alias( 'Booking' ).

    " View annotations.
    lo_view_entity_i_booking->add_annotation( 'AbapCatalog.sqlViewName' )->value->build( )->add_string( CONV #( sqlviewname_a_booking ) ).
    lo_view_entity_i_booking->add_annotation( 'AccessControl.authorizationCheck' )->value->build( )->add_enum( 'CHECK' ).
    lo_view_entity_i_booking->add_annotation( 'EndUserText.label' )->value->build( )->add_string( 'Booking view entity for booking analysis' ).
    lo_view_entity_i_booking->add_annotation( 'Metadata.allowExtensions' )->value->build( )->add_boolean( abap_true ).
    lo_view_entity_i_booking->add_annotation( 'AbapCatalog.preserveKey' )->value->build( )->add_boolean( abap_true ).

    lo_view_entity_i_booking->set_root( ).

    " add associations
    DATA(lo_condition_i_booking) = xco_cp_ddl=>field( 'TravelUUID' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'TravelUUID' )->of( '_Travel' ) ).
    lo_view_entity_i_booking->add_association( i_view_name_a_travel )->set_cardinality( xco_cp_cds=>cardinality->range( iv_min = 0 iv_max = 1 ) )->set_alias( '_Travel' )->set_condition( lo_condition_i_booking ).

    lo_condition_i_booking = xco_cp_ddl=>field( 'CarrierID' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'AirlineID' )->of( '_Connection' ) )->and( xco_cp_ddl=>field( 'ConnectionID' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'ConnectionID' )->of( '_Connection' ) ) ).
    lo_view_entity_i_booking->add_association( i_view_name_connection )->set_cardinality( xco_cp_cds=>cardinality->range( iv_min = 1 iv_max = 1 ) )->set_alias( '_Connection' )->set_condition( lo_condition_i_booking ).

    lo_condition_i_booking = xco_cp_ddl=>field( 'CarrierID' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'AirlineID' )->of( '_Carrier' ) ).
    lo_view_entity_i_booking->add_association( i_view_name_carrier )->set_cardinality( xco_cp_cds=>cardinality->range( iv_min = 1 iv_max = 1 ) )->set_alias( '_Carrier' )->set_condition( lo_condition_i_booking ).

    lo_condition_i_booking = xco_cp_ddl=>field( 'CustomerID' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'CustomerID' )->of( '_Customer' ) ).
    lo_view_entity_i_booking->add_association( '/DMO/I_Customer' )->set_cardinality( xco_cp_cds=>cardinality->range( iv_min = 0 iv_max = 1 ) )->set_alias( '_Customer' )->set_condition( lo_condition_i_booking ).

    lo_condition_i_booking = xco_cp_ddl=>field( 'AgencyID' )->of_projection( )->eq(
      xco_cp_ddl=>field( 'AgencyID' )->of( '_Agency' ) ).
    lo_view_entity_i_booking->add_association( '/DMO/I_Agency' )->set_cardinality( xco_cp_cds=>cardinality->range( iv_min = 0 iv_max = 1 ) )->set_alias( '_Agency' )->set_condition( lo_condition_i_booking ).

    " Add fields.
    DATA(lo_identifier_i_booking) = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'booking_uuid' ) )->set_key( )->set_alias( 'BookingUUID' ).

    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'travel_uuid' ) )->set_alias( 'TravelUUID' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'booking_id' ) )->set_alias( 'BookingID' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'booking_date' ) )->set_alias( 'BookingDate' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'SUBSTRING (booking_date,1,4)' ) )->set_alias( 'BookingDateYear' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'customer_id' ) )->set_alias( 'CustomerID' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( '_Customer.LastName' ) )->set_alias( 'CustomerName' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'carrier_id' ) )->set_alias( 'CarrierID' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( '_Carrier.Name' ) )->set_alias( 'CarrierName' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'connection_id' ) )->set_alias( 'ConnectionID' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'flight_date' ) )->set_alias( 'FlightDate' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'flight_price' ) )->set_alias( 'FlightPrice' ).
    lo_identifier_i_booking->add_annotation( 'Semantics.amount.currencyCode' )->value->build( )->add_string( 'CurrencyCode' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'currency_code' ) )->set_alias( 'CurrencyCode' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( '_Travel.AgencyID' ) )->set_alias( 'AgencyID' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( '_Travel._Agency.Name' ) )->set_alias( 'AgencyName' ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'CREATED_BY' ) )->set_alias( 'CreatedBy' ).
    lo_identifier_i_booking->add_annotation( 'Semantics.user.createdBy' )->value->build( )->add_boolean( abap_true ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'LAST_CHANGED_BY' ) )->set_alias( 'LastChangedBy' ).
    lo_identifier_i_booking->add_annotation( 'Semantics.user.lastChangedBy' )->value->build( )->add_boolean( abap_true ).
    lo_identifier_i_booking = lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( 'LOCAL_LAST_CHANGED_AT' ) )->set_alias( 'LocalLastChangedAt' ).
    lo_identifier_i_booking->add_annotation( 'Semantics.systemDateTime.localInstanceLastChangedAt' )->value->build( )->add_boolean( abap_true ).

    " add association to publish
    lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( '_Travel' ) ).
    lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( '_Carrier' ) ).
    lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( '_Customer' ) ).
    lo_view_entity_i_booking->add_field( xco_cp_ddl=>field( '_Connection' ) ).


* Create consumption view
    DATA(lo_interface_specification) = io_put_operation1->for-ddls->add_object( c_view_name_a_booking
      )->set_package( package_name
      )->create_form_specification( ).

    DATA(lo_view_entity) = lo_interface_specification->set_short_description( 'Booking Analysis view for Travel Scenario'
      )->add_projection_view( ).
    lo_view_entity->data_source->set_view_entity( iv_view_entity = i_view_name_a_booking ).

    lo_view_entity->add_annotation( 'AccessControl.authorizationCheck' )->value->build( )->add_enum( 'CHECK' ).
    lo_view_entity->add_annotation( 'Metadata.allowExtensions' )->value->build( )->add_boolean( abap_true ).
    lo_view_entity->add_annotation( 'EndUserText.label' )->value->build( )->add_string( 'Projection View for Booking Analysis' ).
    lo_view_entity->add_annotation( 'Search.searchable' )->value->build( )->add_boolean( abap_true ).

    lo_view_entity->set_root( ).
    " Add fields.
    DATA(lo_identifier) = lo_view_entity->add_field( xco_cp_ddl=>field( 'BookingUUID' ) )->set_key( ).

    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'TravelUUID' ) ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'BookingID' ) ).
    lo_identifier->add_annotation( 'Search.defaultSearchElement' )->value->build( )->add_boolean( abap_true ).
    lo_identifier->add_annotation( 'Search.fuzzinessThreshold' )->value->build( )->add_number( '0.9' ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'BookingDate' ) ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'BookingDateYear' ) ).
    lo_identifier->add_annotation( 'EndUserText.label' )->value->build( )->add_string( 'Booking Date (Year)' ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'CustomerID' ) ).
    lo_identifier->add_annotation( 'EndUserText.label' )->value->build( )->add_string( 'Customer' ).
    lo_identifier->add_annotation( 'ObjectModel.text.element' )->value->build( )->begin_array( )->add_string( 'CustomerName' ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'CustomerName' ) ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'CarrierID' ) ).
    lo_identifier->add_annotation( 'EndUserText.label' )->value->build( )->add_string( 'Airline' ).
    lo_identifier->add_annotation( 'ObjectModel.text.element' )->value->build( )->begin_array( )->add_string( 'CarrierName' ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'CarrierName' ) ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'ConnectionID' ) ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'FlightDate' ) ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'FlightPrice' ) ).
    lo_identifier->add_annotation( 'Semantics.amount.currencyCode' )->value->build( )->add_string( 'CurrencyCode' ).
    lo_identifier->add_annotation( 'Aggregation.default' )->value->build( )->add_enum( 'SUM' ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'CurrencyCode' ) ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'AgencyID' ) ).
    lo_identifier->add_annotation( 'EndUserText.label' )->value->build( )->add_string( 'Agency' ).
    lo_identifier->add_annotation( 'ObjectModel.text.element' )->value->build( )->begin_array( )->add_string( 'AgencyName' ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'AgencyName' ) ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'CreatedBy' ) ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'LastChangedBy' ) ).
    lo_identifier = lo_view_entity->add_field( xco_cp_ddl=>field( 'LocalLastChangedAt' ) ).


    lo_view_entity->add_field( xco_cp_ddl=>field( '_Travel' ) ).
    lo_view_entity->add_field( xco_cp_ddl=>field( '_Carrier' ) ).
    lo_view_entity->add_field( xco_cp_ddl=>field( '_Customer' ) ).
    lo_view_entity->add_field( xco_cp_ddl=>field( '_Connection' ) ).

*   Create service definition

    TYPES: BEGIN OF ty_cds_views_used_by_assoc,
             name   TYPE /dmo/cl_rap_node=>ts_assocation-name,    "    sxco_ddef_alias_name,
             target TYPE /dmo/cl_rap_node=>ts_assocation-target,
           END OF ty_cds_views_used_by_assoc.
    DATA  lt_cds_views_used_by_assoc  TYPE STANDARD TABLE OF ty_cds_views_used_by_assoc.
    DATA  ls_cds_views_used_by_assoc  TYPE ty_cds_views_used_by_assoc.

    DATA(lo_specification_header) = io_put_operation1->for-srvd->add_object( srv_definition_analytics
                                    )->set_package( package_name
                                    )->create_form_specification( ).

    lo_specification_header->set_short_description( |Service definition for booking analysis|  ).

    "add exposure for root node
    lo_specification_header->add_exposure( c_view_name_a_booking )->set_alias( 'Booking' ).
    lo_specification_header->add_exposure( i_view_name_a_travel )->set_alias( 'Travel' ).
    lo_specification_header->add_exposure( |ZI_FE_CONN_{ unique_suffix }| )->set_alias( 'Connection' ).
    lo_specification_header->add_exposure( |ZI_FE_FLIG_{ unique_suffix }| )->set_alias( 'Flight' ).
    lo_specification_header->add_exposure( |ZI_FE_CARR_{ unique_suffix }| )->set_alias( 'Airline' ).
    lo_specification_header->add_exposure( |I_CURRENCY| )->set_alias( 'Currency' ).
    lo_specification_header->add_exposure( |/DMO/I_CUSTOMER| )->set_alias( 'Customer' ).
    lo_specification_header->add_exposure( |/DMO/I_AGENCY| )->set_alias( 'Agency' ).


*   Create service binding

    DATA lv_service_binding_name TYPE sxco_srvb_object_name.
    lv_service_binding_name = to_upper( srv_binding_analytics ).

    DATA lv_service_definition_name TYPE sxco_srvd_object_name.
    lv_service_definition_name = to_upper( srv_definition_analytics ).

    DATA(lo_specification_header2) = io_put_operation2->for-srvb->add_object(   lv_service_binding_name
                                    )->set_package( package_name
                                    )->create_form_specification( ).

    lo_specification_header2->set_short_description( |Service binding for booking analysis| ).

    lo_specification_header2->set_binding_type( xco_cp_service_binding=>binding_type->odata_v2_ui ).


    lo_specification_header2->add_service( )->add_version( '0001' )->set_service_definition( lv_service_definition_name ).

  ENDMETHOD.
ENDCLASS.
