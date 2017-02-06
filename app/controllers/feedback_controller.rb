class FeedbackController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:index, :calculate]
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate, :only => [:index, :list]
  before_action :is_admin

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @date_today = (@date).strftime("%F")
    @date_2weeks_ago = (@date - 2.weeks).strftime("%F")
    @date_3months_ago = (@date - 3.months).strftime("%F")
    if Rails.env.production? || Rails.env.staging?
      @tablet_interviews_today = Fctabletinterview.where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", (@date.to_s)).order("uptdate desc")
      @tablet_interviews_2_weeks_ago = Fctabletinterview.where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", ((@date - 2.weeks).to_s)).order("uptdate desc")
      @tablet_interviews_3_months_ago = Fctabletinterview.where("to_char(to_date(uptdate), 'YYYY-MM-DD') LIKE ?", ((@date - 3.months).to_s)).order("uptdate desc")
    else
      @tablet_interviews_today = Fctabletinterview.all
      @tablet_interviews_2_weeks_ago = Fctabletinterview.all
      @tablet_interviews_3_months_ago = Fctabletinterview.all
    end

    create_new_fcafterservice(@tablet_interviews_today)
    create_new_fcafterservice(@tablet_interviews_2_weeks_ago)
    create_new_fcafterservice(@tablet_interviews_3_months_ago)
  end

  def create_new_fcafterservice(relation)
    relation.each do |tabletinterview|
      if Fcafterinterview.where(custserial: tabletinterview.custserial).where(tablet_interview_id: tabletinterview.tablet_interview_id).count == 0
        if Fcafterinterview.where(custserial: tabletinterview.custserial).where(tablet_interview_id: tabletinterview.tablet_interview_id).where(after_interview_id: 0).count == 0
          after_interview = Fcafterinterview.new
          after_interview.custserial = tabletinterview.custserial
          after_interview.tablet_interview_id = tabletinterview.tablet_interview_id
          after_interview.after_interview_id = 0
          after_interview.save
        end

        if Fcafterinterview.where(custserial: tabletinterview.custserial).where(tablet_interview_id: tabletinterview.tablet_interview_id).where(after_interview_id: 1).count == 0
          after_interview = Fcafterinterview.new
          after_interview.custserial = tabletinterview.custserial
          after_interview.tablet_interview_id = tabletinterview.tablet_interview_id
          after_interview.after_interview_id = 1
          after_interview.save
        end

        if Fcafterinterview.where(custserial: tabletinterview.custserial).where(tablet_interview_id: tabletinterview.tablet_interview_id).where(after_interview_id: 2).count == 0
          after_interview = Fcafterinterview.new
          after_interview.custserial = tabletinterview.custserial
          after_interview.tablet_interview_id = tabletinterview.tablet_interview_id
          after_interview.after_interview_id = 2
          after_interview.save
        end
      end
    end
  end

  def list
    @start_date = Date.today
    @end_date = Date.today

    @average_a1 = 0
    @average_a2 = 0
    @average_a3 = 0
    @average_a4 = 0

    select_sex = params[:sex]
    start_date = params[:start_date]
    end_date = params[:start_age]
    start_age = params[:start_age]
    end_age = params[:end_age]
    select_base = params[:select_base]
    select_ample1 = params[:select_ample1]
    select_ample2 = params[:select_ample2]

    if !start_date.nil?
      @start_date = start_date.to_time
    end
    if !end_date.nil?
      @end_date = end_date.to_time
    end

    @after_interviews = []
    if Rails.env.production? || Rails.env.staging?
      temp_after_interviews = Fcafterinterview.where.not(a1: nil)
      temp_after_interviews.each do |after_interview|
        is_contain = true
        custinfo = Custinfo.where(custserial: after_interview.custserial).first
        if custinfo.sex != select_sex
          is_contain = false
        end
        temp_age = Time.current.year.to_i - custinfo.birthyy.to_i
        if temp_age < start_age || temp_age > end_age
          is_contain = false
        end

        tablet_interview = Fctabletinterview.where(tablet_interview_id: after_interview.tablet_interview_id).first
        if tablet_interview.uptdate.to_date < @start_date || tablet_interview.uptdate.to_date > @end_date
          is_contain = false
        end

        if select_base != "all"
          if tablet_interview.solution_after_serum != select_base
            is_contain = false
          end
        end

        if select_ample1 != "all"
          if tablet_interview.solution_after_ample_1 != select_ample1
            is_contain = false
          end
        end

        if select_ample2 != "all"
          if tablet_interview.solution_after_ample_2 != select_ample2
            is_contain = false
          end
        end
      end
    end

    @after_interviews.each do |interview|
      @average_a1 = @average_a1 + interview.a1.to_i
      @average_a2 = @average_a2 + interview.a2.to_i
      @average_a3 = @average_a3 + interview.a3.to_i
      @average_a4 = @average_a4 + interview.a4.to_i
    end

    @count = @after_interviews.count
    divider = 0
    if @count != 0
      divider = @count
    end
    if @average_a1 != 0
      @average_a1 = (@average_a1 / divider).to_f
    end
    if @average_a2 != 0
      @average_a2 = (@average_a2 / divider).to_f
    end
    if @average_a3 != 0
      @average_a3 = (@average_a3 / divider).to_f
    end
    if @average_a4 != 0
      @average_a4 = (@average_a4 / divider).to_f
    end
    render 'list'
  end

  def is_admin
    if current_admin_user == nil
      redirect_to '/'
    end
  end
end
