import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/ui/views/detay_sayfa.dart';
import 'package:kisiler_uygulamasi/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapabiliyorMu = false;

  Future<void> ara(String aramaKelimesi) async {
    print("Kişi Ara : $aramaKelimesi");
  }

  Future<List<Kisiler>> kisileriYukle() async {
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisi_id: 1, kisi_ad: "Ali", kisi_tel: "1111");
    var k2 = Kisiler(kisi_id: 2, kisi_ad: "Umut Can", kisi_tel: "2222");
    var k3 = Kisiler(kisi_id: 3, kisi_ad: "Ayşe", kisi_tel: "3333");
    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);
    return kisilerListesi;
  }
  Future<void> sil(int kisi_id) async {
    print("Kişi Sil: $kisi_id");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapabiliyorMu ?
        TextField(
          decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu){
            ara(aramaSonucu);
          },
        ):
        const Text("Kişiler"),
        actions: [
          aramaYapabiliyorMu ?
          IconButton(onPressed: (){
            setState(() {
              aramaYapabiliyorMu = false;
            });
          },
              icon: const Icon(Icons.clear)) :
          IconButton(onPressed: (){
            setState(() {
              aramaYapabiliyorMu = true;
            });
          },
              icon: const Icon(Icons.search))
        ],
      ),

      body: FutureBuilder<List<Kisiler>>(
        future: kisileriYukle(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var kisilerListesi = snapshot.data;
            return ListView.builder(
              itemCount: kisilerListesi!.length,//3
              itemBuilder: (context,indeks){//0,1,2
                var kisi = kisilerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetaySayfa(kisi: kisi)))
                        .then((value) {
                      print("Anasayfaya Dönüldü");
                    }
                    );
                  },
                  child: Card(
                    child: SizedBox(height: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(kisi.kisi_ad,style: const TextStyle(fontSize: 20),),
                                Text(kisi.kisi_tel),
                              ],
                            ),
                          ),
                  const Spacer(),
                  IconButton(onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${kisi.kisi_ad} silinsin mi ?"),
                            action: SnackBarAction(
                              label: "Evet",
                              onPressed: (){
                                sil(kisi.kisi_id);
                              },
                            ),
                            )
                      );
                  },icon: const Icon(Icons.clear,color: Colors.black54,),)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
    }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const KayitSayfa()))
              .then((value) {
              print("Anasayfaya Dönüldü");
          }
          );
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}
