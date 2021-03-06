class Api::GeneInterview::GeneInterviewController < Api::ApplicationController
  def index
    interview = FcgeneInterview.where(custserial: params[:custserial], measureno: params[:measureno].to_i).first
    if !interview.nil?
      render json: interview.to_api_hash, status: :ok
    else
      render :text => "FcgeneInterview is not exist!!!", status: 204
    end
  end

  def create
    if params[:gene_barcode] != "0000000000000" && FcgeneInterview.where(gene_barcode: params[:gene_barcode]).count > 0
      render :text => "gene_barcode is exist!!!", status: 204
    else
      interview = FcgeneInterview.new(permitted_params)

      t = Time.now
      interview.uptdate = t.to_s.split(" ")[0]

      if interview.save
        render json: interview.to_api_hash, status: :ok
      else
        render :text => "Fail!!!", status: 404
      end
    end
  end

  def update
    interview = FcgeneInterview.where(custserial: params[:custserial], measureno: params[:measureno].to_i).first
    if !interview.nil?
      if interview.gene_barcode != params[:gene_barcode] && params[:gene_barcode] != "0000000000000" && FcgeneInterview.where(gene_barcode: params[:gene_barcode]).count > 0
        render :text => "gene_barcode is exist!!!", status: 204
      else
        interview.update(permitted_params)
        t = Time.now
        interview.uptdate = t.to_s.split(" ")[0]

        if interview.save
          render json: interview.to_api_hash, status: :ok
        else
          render :text => "Fail!!!", status: 404
        end
      end
    else
      render :text => "FcgeneInterview is not exist!!!", status: 204
    end
  end

  private
  def permitted_params
    params.permit(:custserial, :ch_cd, :gene_barcode, :measureno, :shop_cd, :q1_height, :q1_weight,
    :q2, :q3, :q4, :q5, :q6, :q7, :q8, :q9, :q10, :q11, :q12, :q13, :q14, :uptdate, :q15_nation, :q15_birth_nation)
  end
end
