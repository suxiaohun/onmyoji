
# todo导出表结构




def download_xls

  Spreadsheet.client_encoding = 'UTF-8'

  book = Spreadsheet::Workbook.new

  model_names = %w(MdmEquipment MdmEquipmentType Sequence StoreHouse WmInvMatType WmInvOrder WmInvOrderDetail WmInvOrderType WmInventory WmInventoryRecord WmMaterial WmMaterialCost WmMaterialDist WmMaterialType WmPurchasingOrder WmPurchasingOrderDetail WmPurchasingOrg WmPurchasingPlan WmPurchasingPlanDetail WmPurchasingRequest WmPurchasingRequestDetail)

  # model_names = Dir["#{Rails.root}/modules/180_cmi_cmi/app/models/cmi/wm_*.rb"].map do |f|

  #   f = f[f.rindex('/'), f.length - f.rindex('/')]

  #   f.chomp('.rb').camelize.gsub('::', '')

  # end



  model_names.each do |model|

    name = 'Cmi::' + model

    sheet = book.create_worksheet :name => eval(name).table_name

    sheet.insert_row(0, ['表名', ''])

    sheet.insert_row(1, ['表技术名', eval(name).table_name])

    sheet.insert_row(2, ['描述', ''])

    sheet.insert_row(3, ['限制', ''])

    sheet.insert_row(6, ['字段', '字段名', '字段类型', '长度', '小数位', '是否必须', '默认值', '备注'])





    eval(name).columns.each_with_index do |col, index|



      desc_hash = {:created_by => '创建人', :updated_by => '更新人', :created_at => '创建时间',

                   :updated_at => '更新时间', :external_system_id => '系统id', :status_code => '状态（ENABLED）',

                   :company_id => '公司id', :project_id => '项目id', :sh_id => '仓库id', :mat_id => '物料id',

                   :mat_number => '物料number', :name => '名称', :mat_name => '物料名称', :price => '价格',

                   :count => '数量', :uom => '单位', :cost => '成本', :standard_cost => '成本',

                   :remark => '备注', :status => '单据状态', :id => 'id', :require_date => '交货日期',

                   :assets_number => '固定资产编号', :profit_center_id => '成本中心id', :auto_delivery => '自动交货（Y/N）',

                   :equipment_number => '设备编号', :batch_id => '批次id', :batch_number => '批次number', :order_type_code => '出入库类型',

                   :mat_type_code => '物料移动类型', :flag => '标志位', :mat_uom => '单位', :start_date => '开始日期', :end_date => '结束日期',

                   :code => '编码', :is_system => '是否是系统初始化字段', :description => '描述/备注',

                   :sequence_id => 'sequence编码id', :expired_at => '过期日期', :supplier_id => '供应商id', :org_id => '组织id',

                   :inv_count => '已入库数量', :cost_center_id => '利润中心id', :batch_control => '批次控制',

                   :equipment_type => '设备类型id', :equipment_name => '设备名称', :equipment_barcode => '设备条形码', :equipment_serial => '设备序列号',

                   :equipment_uom => '计量单位', :user_id => '户号', :type_number => '类型编号', :type_name => '类型名称',

                   :opu_id => '层级id', :object_name => 'model的name+场景缩写', :seq_next => '当前值', :seq_length => '长度',

                   :seq_min => '最小值', :seq_max => '最大值', :rules => '拼接规则', :sh_number => '仓库编号', :sh_name => '仓库名称',

                   :sh_type => '仓库类型', :sh_address => '仓库地址', :number => '编号', :source_order => '来源单据', :source_order_id => '来源单据id',

                   :source_order_number => '来源单据number', :order_id => '单据id', :invoiced_count => '开票数量', :line_mode => '采购类型', :line_type => '单据类型',

                   :line_id => '行信息的id', :order_type => '单据类型', :price_mode => '是否手动维护价格', :total_count => '库存总量',

                   :predict_count => '库存占用量', :order_number => '单据number', :order_date => '业务日期', :mat_type_id => '物料类型id',

                   :mat_model => '规格型号', :auto_order => '自动订货', :safety_stock => '安全库存', :avg_price => '物料移动平均价',

                   :type_code => '类型编码', :number_mode => '编码形式', :purchase_subject => '采购科目', :inventory_subject => '库存科目',

                   :po_source => '订单来源', :po_number => '订单编号', :po_type => '采购类型', :po_purpose => '采购用途', :po_tax_code => '税码',

                   :po_currency => '币种', :pr_id => '申请id', :po_id => '采购订单id', :group_id => '集团id', :org_code => '采购组织名称code',

                   :org_name => '采购组织名称', :pp_number => '计划编号', :pp_type => '计划类型', :pp_id => '计划id', :mode => '采购类型',

                   :pr_number => '申请编号', :pr_source => '申请来源', :pr_type => '采购类型', :type_attribute => '仪表属性', :parent_id => '父类型',

                   :equipment_significance => '重要性',

                   :equipment_status => '设备状态',

                   :purchasing_date => '购置日期',

                   :equipment_supplier => '供应商',

                   :equipment_manufacture => '生产厂家',

                   :equipment_model => '规格型号',

                   :production_date => '生产日期',

                   :factory_number => '出厂编号',

                   :install_date => '安装日期',

                   :use_date => '启用日期',

                   :maintenance_type => '保养类型', :change_equipment_id => '更换仪表id',

                   :durable_year => '使用年限', :change_reason => '更换原因',

                   :guarantee_date => '保修到期日', :equipment_picture_file_name => 'paperclip默认参数',

                   :indicative_price => '参考价格', :equipment_picture_content_type => 'paperclip默认参数',

                   :equipment_attachment => '附件', :equipment_picture_file_size => 'paperclip默认参数',

                   :equipment_picture => '照片', :equipment_picture_updated_at => 'paperclip默认参数',

                   :technical_parameter => '设备参数',

                   :father_equipment => '父设备',

                   :location_code => '位置'}

      col_desc = ''

      col_desc = desc_hash[col.name.to_sym] if desc_hash.has_key? col.name.to_sym



      sheet.insert_row(6 + 1 + index, [col.name, col_desc, col.sql_type, col.limit, col.scale||0, col.primary == true ? '1' : '', col.default, ''])





      for co in 0..9

        sheet.rows[6 + 1 + index].set_format(co, ExcelUtil::FORMAT_TABLE2)

        sheet.merge_cells(6 + 1 + index, 7, 6 + 1 + index, 9)

      end



      sheet.rows[6 + 1 + index].set_format(3, ExcelUtil::FORMAT_TABLE4)

      sheet.rows[6 + 1 + index].set_format(4, ExcelUtil::FORMAT_TABLE4)

      sheet.rows[6 + 1 + index].set_format(5, ExcelUtil::FORMAT_TABLE4)

    end



    sheet.merge_cells(0, 1, 0, 9)

    sheet.merge_cells(1, 1, 1, 9)

    sheet.merge_cells(2, 1, 2, 9)

    sheet.merge_cells(3, 1, 3, 9)



    for co in 7..9

      sheet.rows[0].set_format(co, ExcelUtil::FORMAT_TABLE3)

      sheet.rows[1].set_format(co, ExcelUtil::FORMAT_TABLE3)

      sheet.rows[2].set_format(co, ExcelUtil::FORMAT_TABLE3)

      sheet.rows[3].set_format(co, ExcelUtil::FORMAT_TABLE3)



    end





    for co in 1..9

      sheet.rows[0].set_format(co, ExcelUtil::FORMAT_TABLE3)

      sheet.rows[1].set_format(co, ExcelUtil::FORMAT_TABLE3)

      sheet.rows[2].set_format(co, ExcelUtil::FORMAT_TABLE3)

      sheet.rows[3].set_format(co, ExcelUtil::FORMAT_TABLE3)

    end



    sheet.rows[0].set_format(0, ExcelUtil::FORMAT_TABLE1)

    sheet.rows[1].set_format(0, ExcelUtil::FORMAT_TABLE1)

    sheet.rows[2].set_format(0, ExcelUtil::FORMAT_TABLE1)

    sheet.rows[3].set_format(0, ExcelUtil::FORMAT_TABLE1)



    for co in 0..9

      sheet.rows[6].set_format(co, ExcelUtil::FORMAT_TABLE1)

    end

    sheet.merge_cells(6, 7, 6, 9)

    sheet.column(0).width = 22.75 *1.3

    sheet.column(1).width = 14.5*1.3

    sheet.column(2).width = 10.38*1.3

    sheet.column(3).width = 10.38*1.3

    sheet.column(4).width = 10.38*1.3

    sheet.column(5).width = 10.38*1.3

    sheet.column(6).width = 10.38*1.3

    sheet.column(7).width = 10.38*1.3

    sheet.column(8).width = 10.38*1.3

    sheet.column(9).width = 10.38*1.3

    ExcelUtil.auto_fix_height sheet

  end





  file_name = 'table.xls'

  book.write "#{Rails.root.to_s}/public/data/template/#{file_name}"

  send_file("#{Rails.root.to_s}/public/data/template/#{file_name}",

            :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment",

            :stream => true, :buffer_size => 4096, :filename => file_name)

end




