@AbapCatalog.sqlViewName: 'ZDMV_STUDENT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Student data CDS View'
@Metadata.ignorePropagatedAnnotations: true
define view ZAII_I_STUDENT
  as select from zaii_student
{
  key student_id    as StudentId,
      university_id as UniversityId,
      name          as Name,
      age           as Age,
      major         as Major,
      email         as Email
}
