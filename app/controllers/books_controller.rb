class BooksController < ApplicationController
  before_action :set_book, only: [:show, :next, :previous, :edit, :update, :destroy, :download]

  layout 'tag'

  # GET /books
  def index
    @books = Book.all

  end

  def category
    if params[:id] == 'all'
      @books = Book.includes(:author).all
    else
      @books = Book.includes(:author).where(:category_id => params[:id])
    end
  end


  def test

    puts "......start"
    sleep 3
    puts ".....end"
    # @books = Book.all
    # binding.pry
    result = {}
    result[:data] = {:message=>'ok'}
    render json: result
  end

  # GET /books/1
  def show
    @data = {}
    @data[:id] = params[:id]

    File.open(@book.path) do |io|
      @data[:pre_pos] = io.pos
      @data[:curr_pos] = io.pos
      @data[:lines] = io.first(BOOK_DEFAULT_LINES)
      @data[:next_pos] = io.pos
    end

  end

  # def previous
  #   @data = {}
  #   @data[:id] = params[:id]
  #   File.open(@book.path) do |io|
  #     io.pos = (params[:pre_pos].to_i || 0)
  #     @data[:pre_pos] = io.pos
  #     @data[:lines] = io.first(10)
  #     @data[:next_pos] = io.pos
  #   end
  # end

  def next
    @data = {}
    @data[:id] = params[:id]
    File.open(@book.path) do |io|
      io.pos = (params[:next_pos].to_i || 0)
      @data[:lines] = io.first(BOOK_DEFAULT_LINES)
      @data[:next_pos] = io.pos
    end
    # respond_to do |f|
    #   f.html
    #   f.js
    # end
  end

  def download

    filename = "#{Rails.root}/" + @book.path
    send_file filename

    # send_data head_info + body_info, :filename => file_name, :type => 'text/plain;charset=GBK;'
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit

  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  def comments
    @comments = Comment.order("created_at desc").page params[:page]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end



  # Only allow a trusted parameter "white list" through.
  def book_params
    params.require(:book).permit(:name)
  end
end
