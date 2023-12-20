schema "hospitalV1" {
  charset = "utf8mb4"
  collate = "utf8mb4_0900_ai_ci"
  comment = "A schema comment"
}

table "super_admin" {
  schema = schema.hospitalV1
  column "id" {
    null = false
    type = tinyint
    auto_increment = true
  }
  column "username"{
    null = false
    type = varchar(50)
  }
  column "password"{
    null = false
    type = varchar(100)
  }
  primary_key {
    columns = [column.id]
  }
}

table "hospital" {
  schema = schema.hospitalV1
  column "id" {
    null = false
    type = tinyint
    auto_increment = true
  }
  column "name" {
    null = true
    type = varchar(100)
  }
  column "username" {
    null = false
    type = varchar(50)
  }
  column "password" {
    null = false
    type = varchar(100)
  }
  column "phone" {
    null = true
    type = varchar(12)
  }
  column "gst_number" {
    null = true
    type = varchar(50)
  }
  column "address" {
    null = true
    type = varchar(80)
  }
  column "super_specialist" {
    default = true
    type = bool
  }
  column "active" {
    default = true
    type = bool
  }
  column "banner_photo" {
    null = true
    type = varchar(200)
  }
  column "logo_photo" {
    null = true
    type = varchar(200)
  }
  column "created_on" {
    null = false
    type = timestamp
  }
  index "idx_hospital" {
    columns = [column.gst_number, column.username]
    unique = true
  } 
  primary_key {
    columns = [column.id]
  }
}

table "users" {
  schema = schema.hospitalV1
  column "id" {
    null = false
    type = smallint
    auto_increment = true
  }
  column "name" {
    null = true
    type = varchar(50)
  }
  column "pincode" {
    null = true
    type = varchar(10)
  }
  column "address" {
    null = true
    type = varchar(60)
  }
  column "phone"{
    null=false
    type=varchar(12)
  }
  column "gender" {
    null = false
    type = enum("M","F","O")
  }
  column "created_on" {
    null = false
    type = timestamp
  }
  index "idx_user" {
    columns = [column.phone, column.name]
    unique = true
  }

  primary_key {
    columns = [column.id]
  }

}

table "tests" {
  schema = schema.hospitalV1
  column "id" {
    null = false
    type = int
    auto_increment = true
  }
  column "doctor_id" {
    null = false
    type = smallint
    }
  column "tenant_id" {
    null = false
    type = tinyint
  }
  column "name" {
    null = false
    type = varchar(50)
  }
  column "amount" {
    null = false
    type = int
  }
  column "branch" {
    null = false
    type = varchar(20)
  }
  primary_key {
    columns = [column.id]
  }

  foreign_key "test_hospital_fk" {
    columns     = [column.tenant_id]
    ref_columns = [table.hospital.column.id]
  }
    foreign_key "test_doctor_fk" {
    columns     = [column.doctor_id]
    ref_columns = [table.doctor.column.id]
  }
  index "idx_text" {
    columns = [column.doctor_id, column.tenant_id, column.id]
    unique = true
  }
}

table "symptoms"{
  schema = schema.hospitalV1
  column "id" {
    null = false
    type = smallint
    auto_increment = true
  }
  column "doctor_id" {
    null = false
    type = smallint
    }
  column "tenant_id" {
    null = false
    type = tinyint
  }
  column "name" {
    null = false
    type = varchar(20)
  }
  column "cause" {
    null = false
    type = varchar(30)
  }
  column "created_on" {
    null = false
    type = timestamp
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "symptom_hospital_fk" {
    columns     = [column.tenant_id]
    ref_columns = [table.hospital.column.id]
  }
  foreign_key "symptom_doctor_fk" {
    columns     = [column.doctor_id]
    ref_columns = [table.doctor.column.id]
  }
  index "idx_symptoms" {
    columns = [column.doctor_id, column.tenant_id, column.id]
    unique = true
  }
}

table "doctor" {
  schema = schema.hospitalV1
  column "id" {
    null = false
    type = smallint
    auto_increment = true
  }
  column "tenant_id" {
    null = false
    type = tinyint
  }
  column "user_id" {
    null = false
    type = smallint
  }
  column "specialization" {
    null = true
    type = varchar(100)
  }
  column "reg_no"{
    null = false
    type = varchar(15)
  }

  column "profile_photo" {
    null = true
    type = varchar(200)
  }

  column "active" {
    default = true
    type = bool
  }
  column "created_on" {
    null = false
    type = timestamp
  }

  index "idx_doc"{
    columns = [column.tenant_id, column.reg_no, column.user_id]
    unique = true
  }
  primary_key {
    columns = [column.id, column.tenant_id]
  }
  foreign_key "doctor_user_fk" {
    columns     = [column.user_id]
    ref_columns = [table.users.column.id]
  }
  foreign_key "doctor_tenant_fk" {
    columns     = [column.tenant_id]
    ref_columns = [table.hospital.column.id]
  }
}

table "bank_detail"{
  schema = schema.hospitalV1
  column "id" {
    null = false
    type = smallint
    auto_increment = true
  }
  column "tenant_id" {
    null = false
    type = tinyint
  }
  column "staff_id" {
    null = false
    type = smallint
  }
  column "account_no"{
    null=false
    type = varchar(15)
  }
  column "ifsc"{
    null=true
    type = varchar(15)
  }
  column "branch"{
    null=true
    type = varchar(15)
  }
  column "created_on" {
    null = false
    type = timestamp
  }
    index "idx_bank"{
    columns = [column.tenant_id, column.staff_id]
    unique = true
  }
  primary_key {
    columns = [column.id, column.tenant_id]
  }
  foreign_key "bank_user_fk" {
    columns     = [column.staff_id]
    ref_columns = [table.staff.column.id]
  }
  foreign_key "bank_tenant_fk" {
    columns     = [column.tenant_id]
    ref_columns = [table.hospital.column.id]
  }

}

table "credentials"{
  schema = schema.hospitalV1
  column "id"{
    null = false
    type = smallint
    auto_increment = true
  }
  column "user_id"{
    null = false
    type = smallint
  }
  column "tenant_id"{
    null = false
    type = tinyint
  }
  column "username" {
    null = true
    type = varchar(50)
  }
  column "password" {
    null = true
    type = varchar(100)
  }
  index "idx_cred"{
    columns = [column.tenant_id, column.user_id, column.username]
    unique = true
  }
  primary_key {
    columns = [column.id, column.tenant_id]
  }
  foreign_key "cred_user_fk" {
    columns     = [column.user_id]
    ref_columns = [table.users.column.id]
  }
  foreign_key "cred_tenant_fk" {
    columns     = [column.tenant_id]
    ref_columns = [table.hospital.column.id]
  }
}

table "staff" {
  schema = schema.hospitalV1
  column "id" {
    null = false
    type = smallint
    auto_increment = true
  }
  column "tenant_id" {
    null = false
    type = tinyint
  }
  column "user_id" {
    null = false
    type = smallint
  }
  column "reg_no"{
    null = false
    type = varchar(15)
  }
  column "role" {
    null = false
    type = tinyint
  }
  column "profile_photo" {
    null = true
    type = varchar(200)
  }
  column "active" {
    default = true
    type = bool
  }
  column "created_on" {
    null = false
    type = timestamp
  }
  index "idx_staff"{
    columns = [column.user_id,column.tenant_id, column.reg_no]
    unique = true
  }
  primary_key {
    columns = [column.id, column.tenant_id]
  }
  foreign_key "staff_user_fk" {
    columns     = [column.user_id]
    ref_columns = [table.users.column.id]
  }
  foreign_key "staff_tenant_fk" {
    columns     = [column.tenant_id]
    ref_columns = [table.hospital.column.id]
  }
  foreign_key "user_role_fk" {
    columns     = [column.role]
    ref_columns = [table.role.column.id]
  }
}

table "role"{
  schema = schema.hospitalV1
  column "id" {
    null = false
    type = tinyint
    auto_increment = true
  }

  column "name"{
    null = false
    type = varchar(100)
  }

   primary_key {
    columns = [column.id]
  }
}

table "medicine"{
  schema = schema.hospitalV1
  column "id"{
    null = false
    type = smallint
    auto_increment = true
  }
  column "tenant_id" {
    null = false
    type = tinyint
  }
  column "product_name"{
    null = false
    type = varchar(50)
  }
  column "content"{
    null = true
    type = varchar(250)
  }
  column "manifracturer"{
    null = true
    type = varchar(50)
  }
  column "packing"{
    null = true
    type = varchar(5)
  }
  column "is_delete" {
    default = true
    type = bool
  }
     primary_key {
    columns = [column.id, column.tenant_id]
  }
  foreign_key "medicine_tenant_fk" {
    columns     = [column.tenant_id]
    ref_columns = [table.hospital.column.id]
  }
}

table "beds"{
  schema = schema.hospitalV1
  column "id" {
    null = false
    type = tinyint
    auto_increment = true
  }
  column "tenant_id" {
    null = false
    type = tinyint
  }
  column "bed_type"{
    null = true
    type = varchar(10)
  }
  column "unit"{
    null = true
    type = varchar(10)
  }
  column "amount"{
    null = true
    type = varchar(5)
  }
  column "is_delete" {
    default = true
    type = bool
  }
  primary_key {
    columns = [column.id, column.tenant_id]
  }
  foreign_key "beds_tenant_fk" {
    columns     = [column.tenant_id]
    ref_columns = [table.hospital.column.id]
  }
}