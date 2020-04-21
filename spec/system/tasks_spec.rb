require 'rails_helper'

describe 'タスク管理機能', type: :system, js: true do
  # ユーザの作成 -- let で定義する
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザb', email: 'b@example.com') }
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com') }

  # ユーザタスクの作成 -- let! で定義する
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

  before do
    # ログイン画面にアクセス
    visit login_path
    # メールアドレスを入力
    fill_in 'メールアドレス', with: login_user.email
    # パスワードを入力する
    fill_in 'パスワード', with: 'password'
    # 「ログイン」ボタンクリック
    click_button 'ログイン'
  end

  # hared_examples_for を使ってit をまとめる
  shared_examples_for 'ユーザAが作成したタスクが表示される' do
    it { expect(page).to have_content '最初のタスク' }
  end

  describe '一覧表示機能' do
    context 'ユーザAがログインしている時' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザAが作成したタスクが表示される'
    end

    context 'ユーザBがログインしている時' do
      let(:login_user) { user_b }

      it 'ユーザAのタスクが表示されないこと' do
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザAがログインしている時' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザAが作成したタスクが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in 'タスク名', with: task_name
      click_button '登録する'
    end

    context '新規作成画面でタスク名を入力した時' do
      let(:task_name) { '新規作成のテストを書く' }

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面でタスク名を入力しなかった時' do
      let(:task_name) { '' }

      it 'エラーメッセージを返す' do
        within '#error_explanation' do
          expect(page).to have_content 'タスク名を入力してください'
        end
      end
    end
  end
  
end