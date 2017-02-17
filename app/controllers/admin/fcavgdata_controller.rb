class Admin::FcavgdataController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @select_option = params[:select]

    if params.has_key?(:select)
      @select_option = "all"
    end

    @fcavgdatas_list = Fcavgdata.all.where("age LIKE ?", "%#{@select_option}%")
  end
end
