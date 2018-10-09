require "test_helper"

describe WorkChangeColumnOrder do
  let(:work_change_column_order) { WorkChangeColumnOrder.new }

  it "must be valid" do
    value(work_change_column_order).must_be :valid?
  end
end
