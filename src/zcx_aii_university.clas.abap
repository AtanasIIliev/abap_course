CLASS zcx_aii_university DEFINITION
  PUBLIC
  INHERITING FROM cx_static_Check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES:
      if_t100_message,
      if_t100_dyn_msg.

    DATA:
      lv_university_id       TYPE zaiid_university_id READ-ONLY,
      lv_university_name     TYPE zaiid_student_name  READ-ONLY,
      lv_university_location TYPE zaiid_location      READ-ONLY,
      lv_student_id          TYPE zaiid_student_id    READ-ONLY.

    METHODS constructor
      IMPORTING
        textid                 LIKE if_t100_message=>t100key OPTIONAL
        previous               LIKE previous                 OPTIONAL
        lv_university_id       TYPE zaiid_university_id      OPTIONAL
        lv_student_id          TYPE zaiid_student_id         OPTIONAL
        lv_university_name     TYPE zaiid_student_name       OPTIONAL
        lv_university_location TYPE zaiid_location           OPTIONAL.

    CONSTANTS:
      BEGIN OF university_creation_insert_err,
        msgid TYPE symsgid      VALUE 'ZCM_AII_UNIV_SYSTEM',
        msgno TYPE symsgno      VALUE '001',
        attr1 TYPE scx_attrname VALUE 'lv_university_id',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF university_creation_insert_err.

    CONSTANTS:
      BEGIN OF university_commit_error,
        msgid TYPE symsgid      VALUE 'ZCM_AII_UNIV_SYSTEM',
        msgno TYPE symsgno      VALUE '002',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF university_commit_error.

    CONSTANTS:
      BEGIN OF university_student_not_found,
        msgid TYPE symsgid      VALUE 'ZCM_AII_UNIV_SYSTEM',
        msgno TYPE symsgno      VALUE '003',
        attr1 TYPE scx_attrname VALUE 'lv_student_id',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF university_student_not_found.

    CONSTANTS:
      BEGIN OF university_dlt_stundent_err,
        msgid TYPE symsgid      VALUE 'ZCM_AII_UNIV_SYSTEM',
        msgno TYPE symsgno      VALUE '004',
        attr1 TYPE scx_attrname VALUE 'lv_student_id',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF university_dlt_stundent_err.

    CONSTANTS:
      BEGIN OF university_empty_no_students,
        msgid TYPE symsgid      VALUE 'ZCM_AII_UNIV_SYSTEM',
        msgno TYPE symsgno      VALUE '005',
        attr1 TYPE scx_attrname VALUE 'lv_university_id',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF university_empty_no_students.

    CONSTANTS:
      BEGIN OF university_select_sttment_err,
        msgid TYPE symsgid      VALUE 'ZCM_AII_UNIV_SYSTEM',
        msgno TYPE symsgno      VALUE '006',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF university_select_sttment_err.

PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcx_aii_university IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    me->lv_university_id = lv_university_id.
    me->lv_university_name = lv_university_name.
    me->lv_university_location = lv_university_location.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
    IF lv_university_id IS NOT INITIAL.
      me->lv_university_id = lv_university_id.
    ENDIF.
    IF lv_student_id IS NOT INITIAL.
      me->lv_student_id = lv_student_id.
    ENDIF.
    IF lv_university_name IS NOT INITIAL.
      me->lv_university_name = lv_university_name.
    ENDIF.
    IF lv_university_location IS NOT INITIAL.
      me->lv_university_location = lv_university_location.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
