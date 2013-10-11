class  LovedBooksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]	
  before_filter :correct_user,   only: :destroy
  def index
    @loved_books = LovedBook.paginate(page: params[:page]) 
  end
  
  def create
    @user = current_user
    @loved_book = @user.loved_books.build(params[:loved_book])
    @loved_books = @user.loved_books.paginate(page: params[:page])
    if @loved_book.save
      flash[:success] = "Book created!"
      redirect_to @loved_book
    else
      # render 'static_pages/home'
      render template: "users/show"
    end
  end

  def destroy
    @loved_book.destroy
    redirect_to current_user
  end

  def show
    @loved_book = LovedBook.find(params[:id])
    @chapters = @loved_book.chapters
    session[:book_id] = @loved_book.id
  end

  def print
    @loved_book = LovedBook.find(params[:id])
    # format(@loved_book)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "book#{@loved_book.id}.pdf",
        wkhtmltopdf: '/usr/bin/wkhtmltopdf'
      end
    end
  end
  
  private
  def correct_user
    @loved_book = current_user.loved_books.find_by_id(params[:id])
    redirect_to root_url if @loved_book.nil?
  end
  
  def format(book)
    f_list = File.open(Rails.root.join('loved_book') + "list_#{book.id}.md", "w+: utf-8")
    f_book = File.open(Rails.root.join('loved_book') + "content_#{book.id}.md", "w+: utf-8")
    book.chapters.each do |chapter|
      append_chapter(f_list, f_book, chapter, 1)
    end
  end

  def append_chapter(list, book, chapter, level)
    list << "\t" * (level-1) + "* #{chapter.name}\n"
    book << '* ' + headline(chapter.name, level) << chapter.content
    if chapter.chapters.any?
      chapter.chapters.each do |sub_chapter|
        append_chapter(list, book, sub_chapter, level+1)
      end
    end
  end

  def headline(head, level)
    "#" * level + " #{head}\n"
  end
end
