class PiecesController < ApplicationController
  before_action :set_piece, only: [:show, :edit, :update, :destroy]

  # GET /pieces
  def index
    @pieces = Piece.all
  end

  # GET /pieces/1
  def show
  end

  # GET /pieces/new
  def new
    @piece = Piece.new
  end

  # GET /pieces/1/edit
  def edit
  end

  # POST /pieces
  def create
    @piece = Piece.new(piece_params)

    if @piece.save
      redirect_to @piece, notice: 'Piece was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pieces/1
  def update
    if @piece.update(piece_params)
      redirect_to @piece, notice: 'Piece was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pieces/1
  def destroy
    @piece.destroy
    @need_pieces = Piece.where(sama: cookies[:nick_name], mode: 'NEED')
    @own_pieces = Piece.where(sama: cookies[:nick_name], mode: 'OWN')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_piece
    @piece = Piece.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def piece_params
    params.fetch(:piece, {})
  end
end
