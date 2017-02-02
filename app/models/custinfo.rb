class Custinfo < ApplicationRecord
  self.table_name = "custinfo" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :custserial if Rails.env.production? || Rails.env.staging?

  def to_api_hash
    {
      serial: custserial,
      custname: custname,
      sex: sex,
      age: age,
      birthyy: birthyy,
      birthmm: birthmm,
      birthdd: birthdd,
      phone: phone,
      update: uptdate,
      is_agree_privacy: is_agree_privacy,
      is_agree_thirdparty_info: is_agree_thirdparty_info,
      is_agree_marketing: is_agree_marketing,
      is_agree_after: is_agree_after
    }
  end

  def decode_name
    custname
  end
end
