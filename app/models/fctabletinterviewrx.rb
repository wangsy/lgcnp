class Fctabletinterviewrx < ApplicationRecord
  self.table_name = "fctabletinterviewrx" if Rails.env.production? || Rails.env.staging?
  self.primary_key = :tablet_interview_id if Rails.env.production?  || Rails.env.staging?

  def to_api_hash
    {
      custserial: custserial,
      tablet_interview_id: tablet_interview_id,
      a_1: a_1,
      a_2: a_2,
      a_3: a_3,
      b_1: b_1,
      b_2: b_2,
      b_3: b_3,
      b_4: b_4,
      b_5: b_5,
      b_6: b_6,
      c_1: c_1,
      d_1: d_1,
      d_2: d_2,
      d_3: d_3,
      d_4: d_4,
      d_5: d_5,
      d_6: d_6,
      d_7: d_7,
      d_8: d_8,
      d_9: d_9,
      d_10: d_10,
      d_11: d_11,
      skin_type: skin_type,
      before_solution_1: before_solution_1,
      after_solution_1: after_solution_1,
      before_solution_2: before_solution_2,
      after_solution_2: after_solution_2,
      before_ample_1: before_ample_1,
      after_ample_1: after_ample_1,
      before_ample_2: before_ample_2,
      after_ample_2: after_ample_2,
      uptdate: uptdate,
      is_agree_cant_refund: is_agree_cant_refund,
      mmode: mmode,
      before_production: before_production,
      after_production: after_production,
      bb_base: bb_base,
      before_cushion_1: before_cushion_1,
      after_cushion_1: after_cushion_1,
      before_cushion_2: before_cushion_2,
      after_cushion_2: after_cushion_2,
      fcdata_id: fcdata_id,
      turnover_value: turnover_value,
      corneous_value: corneous_value,
      stress_value: stress_value,
      bb_base_before: bb_base_before,
      bb_base_after: bb_base_after,
      recommand_program_step_1: recommand_program_step_1,
      recommand_program_step_2: recommand_program_step_2,
      recommand_program_step_3: recommand_program_step_3,
      purchase1: purchase1,
      purchase2: purchase2,
      purchase3: purchase3,
      base_lot: base_lot,
      ampoule_1_lot: ampoule_1_lot,
      ampoule_2_lot: ampoule_2_lot,
      mixer_name: mixer_name,
      memo: memo
    }
  end
end
