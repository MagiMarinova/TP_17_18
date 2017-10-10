class TasksController < ApplicationController
  require 'csv'
  #require 'linear-regression/linear'
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

  def filters
    csv_file=params[:file]
    csv_path=csv_file.path
    sum=0
    CSV.foreach(csv_path) do |row|
      if row[2].to_i%2==1
        sum+=row[1].to_f
      end
    end
    sum="%.2f" % sum
    render :plain => sum
  end

  def intervals
    csv_file=params[:file]
    csv_path=csv_file.path
    sum=0
    max=0
    lines=0
    i=0
    count=30

    fil.open(csv_path){|f|lines= f.read.count("\n")}

    if lines <= 30
      CSV.foreach(csv_path) do |row|
      max+=row[0].to_f
      end
    elsif lines>30
      CSV.foreach(csv_path) do |row|
        while i<count do
        sum+=row[0].to_f
        i+=1
        end
      end

      if sum>max
          max=sum
      end
    end
    max="%.2f" % max
    render :plain => max
  end
  # def lin_regressions
  #
  # end

end
