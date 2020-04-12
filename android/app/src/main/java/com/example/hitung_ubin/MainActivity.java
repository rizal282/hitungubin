package com.example.hitung_ubin;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "hitungTotalUbin";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                    (call, result) -> {
                      if(call.method.equals("totalUbin")){
                        int pRuang = call.argument("pRuang");
                        int lRuang = call.argument("lRuang");
                        int pUbin = call.argument("pUbin");
                        int lUbin = call.argument("lUbin");

                        int totalUbinPakai = totalUbin(pRuang, lRuang, pUbin, lUbin);

                        result.success(totalUbinPakai);
                      }else{
                        result.error("Gagal", "Gagal Hitung", null);
                      }
                    }
            );
  }

  // method untuk menghitung total ubin yang akan digunakan
  private int totalUbin(int pRuang, int lRuang, int pUbin, int lUbin){
    int totalUbinDipakai;
    int cm = 100; // 100 cm = 1 m

    int luasRuangan = (pRuang * cm) * (lRuang * cm); // ubah total luas ruangan ke satuan cm
    int luasUbin = pUbin * lUbin;

    totalUbinDipakai = luasRuangan / luasUbin;

    return totalUbinDipakai;

  }
}
