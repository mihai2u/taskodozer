require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  def test_create_invalid
    Note.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Note.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end

  def test_edit
    get :edit, :id => Note.first
    assert_template 'edit'
  end

  def test_update_invalid
    Note.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Note.first
    assert_template 'edit'
  end

  def test_update_valid
    Note.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Note.first
    assert_redirected_to root_url
  end

  def test_destroy
    note = Note.first
    delete :destroy, :id => note
    assert_redirected_to root_url
    assert !Note.exists?(note.id)
  end
end
