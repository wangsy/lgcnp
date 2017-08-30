class FcupdateHistory < ApplicationRecord
  self.table_name = "fcupdate_history" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :release_date,:version_name if Rails.env.production?  || Rails.env.staging?

  def to_api_hash
    {
      release_date: release_date,
      version_name: version_name,
      launcher_yn: launcher_yn,
      upt_entry_num: upt_entry_num,
      upt_total_filesize: upt_total_filesize,
      upt_comment: upt_comment
    }
  end

  def self.list(version_name: nil)
    scoped = FcupdateHistory.all
    scoped = scoped.where(version_name: version_name) if version_name.present?
    scoped.order('release_date ASC')
  end
end
