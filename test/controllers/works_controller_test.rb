require "test_helper"

describe WorksController do
  let(:work) { Work.new(category: 'book', title: 'POODR', creator: 'Sandi Metz', publication_year: 2012, description: 'An Agile Primer') }

  it "gets index" do
    get works_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_work_url
    value(response).must_be :success?
  end

  it "creates work" do
    expect {
      post works_url, params: { work: { category: work.category, creator: work.creator, description: work.description, publication_year: work.publication_year, title: work.title } }
    }.must_change "Work.count"

    must_redirect_to work_path(Work.last)
  end

  it "shows work" do
    get work_url(work)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_work_url(work)
    value(response).must_be :success?
  end

  it "updates work" do
    patch work_url(work), params: { work: { category: work.category, creator: work.creator, description: work.description, publication_year: work.publication_year, title: work.title } }
    must_redirect_to work_path(work)
  end

  it "destroys work" do
    expect {
      delete work_url(work)
    }.must_change "Work.count", -1

    must_redirect_to works_path
  end
end
