## wcpay

Wcpay 是一个用于微信公众号扫码支付的gem，可以将微信支付集成到自己开发的网站中。
囊括了，扫码支付 和 退款 两项功能

## useage

```
gem 'wcpay', git: 'https://github.com/oldfritter/wcpay'
```

0.准备

```
configs = YAML.safe_load File.open(File.expand_path('../payment.yml', __dir__))

WCPay.app_id = configs['WCPay']['app_id']
WCPay.app_secret = configs['WCPay']['app_secret']
WCPay.mch_id = configs['WCPay']['mch_id']
WCPay.key = configs['WCPay']['key']
WCPay.set_apiclient_by_pkcs12 File.read(File.expand_path('../pems/apiclient_cert.p12', __dir__)), WCPay.mch_id.to_s
```


1.获取生成支付二维码的字符串

```
WCPay::Service.unified_order(
	body: '商品描述', 
	out_trade_no: '本地订单号', 
	total_fee: 1223, #总金额，分 
	spbill_create_ip: '10.10.222.333', #用户的IP
	notify_url: #异步通知的url
)
```
2.生成二维码供用户扫码支付

3.支付成功后，微信异步通知的校验

```
    nokogiri = Nokogiri::XML(request.body.read)
    params_ha = {}
    nokogiri.children[0].children.each { |child| params_ha[child.name] = child.text unless child.name == 'text' || child.text == "\n  " }
    return render xml: '<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[FAIL]]></return_msg></xml>' if params_ha['result_code'] != 'SUCCESS' || params_ha['return_code'] != 'SUCCESS'
    @order = Order.find_by sn: params_ha['out_trade_no'] # 依据订单号找到对应订单
    @pay_log = @order.wechat_pay_log # @pay_log为微信支付记录
    if WCPay::Sign.verify?(params_ha) && params_ha['total_fee'].to_i == @pay_log.amount
      @pay_log.obtain(trade_no: params_ha['transaction_id']) unless @pay_log.paid? # 确认到款，并记录微信订单号
      render xml: '<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>'
    end
```

4.退款

```
    batch_num = batch_no || WCPay::Utils.generate_batch_no # 生成退款单号
    self.update_attributes batch_no: batch_num, status: PayLog::STATUS[:REFUNDING]
    result = WCPay::Service.refund transaction_id: trade_no, out_refund_no: batch_num, total_fee: amount, refund_fee: amount # 请求退款接口
    self.auto_refund_obtain pay_log_type: 'PayLogs::Wechat' if result['return_code'] == 'SUCCESS' && result['return_msg'] == 'OK' && notify_verify?(result) && result['total_fee'].to_i == amount # 验证退款结果

```
