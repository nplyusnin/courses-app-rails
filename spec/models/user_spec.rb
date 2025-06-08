require 'rails_helper'

RSpec.describe User, type: :model do
  describe "enums" do
    it do
      is_expected.to define_enum_for(:role).with_values(
                                              student: "student", 
                                              teacher: "teacher", 
                                              admin: "admin"
                                            )
                                            .backed_by_column_of_type(:string)
                                            .validating
    end
  end
end
