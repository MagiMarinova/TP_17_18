class SumsController < ApplicationController
  require 'csv'
  def sums
    csv_file=params[:file]
    csv_path=csv_file.path
    sum=0
    CSV.foreach(csv_path) do |row|
        sum+=row[0].to_f
    end
    sum="%.2f" % sum
    render :plain => sum
  end
end
