CLASS zcx_aii_student DEFINITION
  PUBLIC
  INHERITING FROM cx_static_Check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
   INTERFACES:
      if_t100_message,
      if_t100_dyn_msg.

    DATA:
      lv_student_id    TYPE zaiid_student_id    READ-ONLY,
      lv_university_id TYPE zaiid_university_id READ-ONLY,
      lv_student_name  TYPE zaiid_student_name  READ-ONLY,
      lv_student_age   TYPE zaiid_student_age   READ-ONLY,
      lv_student_major TYPE zaiid_student_major READ-ONLY,
      lv_student_email TYPE zaiid_student_email READ-ONLY.

    METHODS constructor
      IMPORTING
        textid           LIKE if_t100_message=>t100key OPTIONAL
        previous         LIKE previous                 OPTIONAL
        lv_student_id    TYPE zaiid_student_id         OPTIONAL
        lv_university_id TYPE zaiid_university_id      OPTIONAL
        lv_student_name  TYPE zaiid_student_name       OPTIONAL
        lv_student_age   TYPE zaiid_student_age        OPTIONAL
        lv_student_major TYPE zaiid_student_major      OPTIONAL
        lv_student_email TYPE zaiid_student_email      OPTIONAL.

    CONSTANTS:
      BEGIN OF student_add_to_uni_error,
        msgid TYPE symsgid      VALUE 'ZCM_AII_UNIV_SYSTEM',
        msgno TYPE symsgno      VALUE '007',
        attr1 TYPE scx_attrname VALUE 'lv_student_id',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF student_add_to_uni_error.

    CONSTANTS:
      BEGIN OF student_creation_insert_err,
        msgid TYPE symsgid      VALUE 'ZCM_AII_UNIV_SYSTEM',
        msgno TYPE symsgno      VALUE '008',
        attr1 TYPE scx_attrname VALUE 'lv_student_id',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF student_creation_insert_err.

    CONSTANTS:
      BEGIN OF student_update_error,
        msgid TYPE symsgid      VALUE 'ZCM_AII_UNIV_SYSTEM',
        msgno TYPE symsgno      VALUE '009',
        attr1 TYPE scx_attrname VALUE 'lv_student_id',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF student_update_error.

    CONSTANTS:
      BEGIN OF student_commit_error,
        msgid TYPE symsgid      VALUE 'ZCM_AII_UNIV_SYSTEM',
        msgno TYPE symsgno      VALUE '002',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF student_commit_error.

    CONSTANTS:
      BEGIN OF student_not_found,
        msgid TYPE symsgid      VALUE 'ZCM_AII_UNIV_SYSTEM',
        msgno TYPE symsgno      VALUE '003',
        attr1 TYPE scx_attrname VALUE 'lv_student_id',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF student_not_found.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_AII_STUDENT IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    me->lv_student_id = lv_student_id.
    me->lv_university_id = lv_university_id.
    me->lv_student_name = lv_student_name.
    me->lv_student_age = lv_student_age.
    me->lv_student_major = lv_student_major.
    me->lv_student_email = lv_student_email.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
    IF lv_student_id IS NOT INITIAL.
      me->lv_student_id = lv_student_id.
    ENDIF.
    IF lv_university_id IS NOT INITIAL.
      me->lv_university_id = lv_university_id.
    ENDIF.
    IF lv_student_name IS NOT INITIAL.
      me->lv_student_name = lv_student_name.
    ENDIF.
    IF lv_student_age IS NOT INITIAL.
      me->lv_student_age = lv_student_age.
    ENDIF.
    IF lv_student_major IS NOT INITIAL.
      me->lv_student_major = lv_student_major.
    ENDIF.
    IF lv_student_email IS NOT INITIAL.
      me->lv_student_email = lv_student_email.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
