require "rails_helper"

describe Officing::Results::FormComponent do
  let(:poll) { create(:poll, ends_at: 1.day.ago) }
  before { create(:poll_question, :yes_no, poll: poll, title: "Agreed?") }

  it "uses number fields with 0 as a default value" do
    render_inline Officing::Results::FormComponent.new(poll, Poll::OfficerAssignment.none)

    page.find(:fieldset, "Agreed?") do |fieldset|
      expect(fieldset).to have_field "Yes", with: 0, type: :number
      expect(fieldset).to have_field "No", with: 0, type: :number
    end

    expect(page).to have_field "Totally blank ballots", with: 0, type: :number
    expect(page).to have_field "Invalid ballots", with: 0, type: :number
    expect(page).to have_field "Valid ballots", with: 0, type: :number
  end
end
