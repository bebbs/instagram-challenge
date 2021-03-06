feature 'Posts' do
  
  context 'Viewing posts' do
    scenario 'No pictures have been added by default' do
      visit '/'

      expect(page).to have_content 'No posts'
      expect(page).to have_link 'Add an image'
    end

    scenario 'Viewing a single post' do
      sign_up_and_in
      create_post('capybara.jpg')
      click_link('Capybara')

      expect(current_path).to include '/posts/'
      expect(page).to have_css('img')
    end
  end

  context 'Creating a post' do

    before { sign_up_and_in }
    scenario 'From the homepage' do
      create_post('capybara.jpg')

      expect(page).to have_css('img')
      expect(page).not_to have_content 'No posts'
    end

    scenario 'With a filter' do
      click_link 'Add an image'
      attach_file 'Image', 'spec/support/capybara2.jpg'
      select 'Sepia', from: 'Filter'
      click_button 'Post Image'

      expect(page).to have_css('img.filter-sepia')
    end
  end

end
