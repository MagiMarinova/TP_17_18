class TasksController < ApplicationController
  require 'csv'
  require 'action_view'
  require "linefit.rb"

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
        csv_file = params[:file]
        max_sum = 0
        id = CSV.read(csv_file.path).size

        arr = Array.new(id)
        i = 0
        CSV.foreach(csv_file.path) do |row|
              arr[i] = row[0].to_f
              i+=1
        end
        i = 0

        until id - 30 < i do
          sum = 0
          j = i
          until j > 30 + i do
            sum += arr[j] || 0
            j+=1
          end
          if sum > max_sum then
              max_sum = sum
          end
          i+=1
        end
        max_sum = max_sum.round(2)
        render plain: number_with_precision(max_sum, precision: 2)
  end
   def lin_regressions
      csv_file = params[:file]
      size = CSV.read(csv_file.path).size
      x = Array.new(size)
      y = Array.new(size)

      CSV.foreach(csv_file.path).with_index do |row, index|
        x[index] = row[0].to_f
        y[index] = row[1].to_f
      end

      lin_reg = LineFit.new
      lin_reg.setData(x, y)
      intercept, slope = lin_reg.coefficients
      render plain: '%.6f, %.6f' % [slope,intercept]
   end

end
