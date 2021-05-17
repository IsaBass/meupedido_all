package br.com.agsystem.MeuPedido



//import io.flutter.app.FlutterActivity


//import android.content.ContextWrapper
//import android.content.Intent
//import android.content.IntentFilter
//import android.os.Bundle
//import com.mercadopago.android.px.internal.util.MercadoPagoUtil
//import com.mercadopago.android.px.model.Payment
import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull
import com.mercadopago.android.px.core.MercadoPagoCheckout
import com.mercadopago.android.px.model.Payment
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugin.common.MethodCall
//import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

//import java.security.PublicKey

//
//import android.os.Build
//import android.view.ViewTreeObserver
//import android.view.WindowManager
//class MainActivity: io.flutter.embedding.android.FlutterActivity() {
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
//    }
//}

import android.os.Build
import android.os.Bundle
import android.view.ViewTreeObserver
import android.view.WindowManager
import io.flutter.Log

class MainActivity: FlutterActivity() {

    private val REQUEST_CODE = 7777;
    private val CHANNEL = "agMeuPedidoOnline.com/mercadoPago";
    private lateinit var _result: MethodChannel.Result


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        //
        iniFlutterChannelsMercadoPago(flutterEngine);
        //
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
      //  iniFlutterChannels()
    }

    private fun iniFlutterChannelsMercadoPago(flutterEngine: FlutterEngine) {

        val channelMercadoPago = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channelMercadoPago.setMethodCallHandler { methodCall, result ->
            if (methodCall.method == "mercadoPagoPague") {
                ///
                _result = result ;
//                val intent = MercadoPagoUtil.getSafeIntent(this@MainActivity)
//                //val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter( MercadoPagoCheckout.EXTRA_PAYMENT_RESULT))
////                intent.putExtra("address", call.argument<String>("address"))
//                startActivityForResult(intent, MercadoPagoCheckout.PAYMENT_RESULT_CODE)
                ////
                val args = methodCall.arguments as HashMap<String, Any>;
                val publicKey = args["publicKey"] as String;
                val preferenceId = args["preferenceId"] as String;
                mercadoPago(publicKey, preferenceId, result);
            }
            else result.notImplemented()

//            when(methodCall.method) {
//                "mercadoPagoPague" -> {
//                    val args = methodCall.arguments as HashMap<String, Any>;
//                    val publicKey = args["publicKey"] as String;
//                    val preferenceId = args["preferenceId"] as String;
//                    mercadoPago(publicKey, preferenceId, result);
//                }
//                else -> return@setMethodCallHandler
//            }
        }

    }

    private fun mercadoPago(publicKey: String, preferenceId: String, channelResult: MethodChannel.Result){
        MercadoPagoCheckout.Builder(publicKey,preferenceId).build().startPayment( this@MainActivity, REQUEST_CODE )
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {



        if(requestCode != REQUEST_CODE) {
            Log.d("","entrou em super result ::: $resultCode  (request code = $requestCode ) ");
            super.onActivityResult(requestCode, resultCode, data)
        } else

        if(resultCode == MercadoPagoCheckout.PAYMENT_RESULT_CODE) {  // resultcode is 7
            Log.d("","entrou NO ACTIVE RESULT DO MERCADO PAGO (request code = $requestCode ) ");

            val payment = data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_PAYMENT_RESULT) as Payment
            val paymentStatus = payment.paymentStatus
            val paymentStatusDetails = payment.paymentStatusDetail
            val paymentId = payment.id

            val arraList = ArrayList<String>();
            arraList.add("MPagoOK");
            arraList.add(paymentId.toString())
            arraList.add(paymentStatus.toString())
            arraList.add(paymentStatusDetails)
            arraList.add(payment.paymentTypeId)
            arraList.add(payment.paymentMethodId)
            arraList.add(payment.operationType)
//            arraList.add(payment.toString())

            _result.success(arraList);

        } else if(resultCode == Activity.RESULT_CANCELED) {  // resultCode is 0 zero
            Log.d("","entrou NO ACTIVE RESULT DO MERCADO PAGO resultCode == Activity.RESULT_CANCELED (request code = $requestCode ) ");
            val arraList = ArrayList<String>();
            arraList.add("MPagoDESISTIU");
            _result.success(arraList);
        } else {
            Log.d("","entrou NO ACTIVE RESULT DO MERCADO PAGO else final (request code = $requestCode ) ");

            val arraList = ArrayList<String>();
            arraList.add("MPagoUnknow");
            _result.success(arraList);
        }

    }
}