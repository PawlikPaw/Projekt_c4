; ModuleID = 'marshal_methods.x86_64.ll'
source_filename = "marshal_methods.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [149 x ptr] zeroinitializer, align 16

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [447 x i64] [
	i64 u0x0071cf2d27b7d61e, ; 0: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 85
	i64 u0x02123411c4e01926, ; 1: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 81
	i64 u0x02abedc11addc1ed, ; 2: lib_Mono.Android.Runtime.dll.so => 147
	i64 u0x032267b2a94db371, ; 3: lib_Xamarin.AndroidX.AppCompat.dll.so => 62
	i64 u0x0363ac97a4cb84e6, ; 4: SQLitePCLRaw.provider.e_sqlite3.dll => 56
	i64 u0x043032f1d071fae0, ; 5: ru/Microsoft.Maui.Controls.resources => 24
	i64 u0x044440a55165631e, ; 6: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 2
	i64 u0x046eb1581a80c6b0, ; 7: vi/Microsoft.Maui.Controls.resources => 30
	i64 u0x0517ef04e06e9f76, ; 8: System.Net.Primitives => 118
	i64 u0x051a3be159e4ef99, ; 9: Xamarin.GooglePlayServices.Tasks => 92
	i64 u0x0565d18c6da3de38, ; 10: Xamarin.AndroidX.RecyclerView => 83
	i64 u0x0581db89237110e9, ; 11: lib_System.Collections.dll.so => 101
	i64 u0x05989cb940b225a9, ; 12: Microsoft.Maui.dll => 48
	i64 u0x06076b5d2b581f08, ; 13: zh-HK/Microsoft.Maui.Controls.resources => 31
	i64 u0x06388ffe9f6c161a, ; 14: System.Xml.Linq.dll => 140
	i64 u0x0680a433c781bb3d, ; 15: Xamarin.AndroidX.Collection.Jvm => 66
	i64 u0x0709729c8c59c760, ; 16: Projekt_c4.dll => 96
	i64 u0x07c57877c7ba78ad, ; 17: ru/Microsoft.Maui.Controls.resources.dll => 24
	i64 u0x07dcdc7460a0c5e4, ; 18: System.Collections.NonGeneric => 99
	i64 u0x08a7c865576bbde7, ; 19: System.Reflection.Primitives => 127
	i64 u0x08f3c9788ee2153c, ; 20: Xamarin.AndroidX.DrawerLayout => 71
	i64 u0x0919c28b89381a0b, ; 21: lib_Microsoft.Extensions.Options.dll.so => 43
	i64 u0x092266563089ae3e, ; 22: lib_System.Collections.NonGeneric.dll.so => 99
	i64 u0x098b50f911ccea8d, ; 23: lib_Xamarin.GooglePlayServices.Basement.dll.so => 90
	i64 u0x09d144a7e214d457, ; 24: System.Security.Cryptography => 134
	i64 u0x0a066c5968b04c8d, ; 25: lib_Firebase.dll.so => 35
	i64 u0x0b3b632c3bbee20c, ; 26: sk/Microsoft.Maui.Controls.resources => 25
	i64 u0x0b6aff547b84fbe9, ; 27: Xamarin.KotlinX.Serialization.Core.Jvm => 95
	i64 u0x0be2e1f8ce4064ed, ; 28: Xamarin.AndroidX.ViewPager => 86
	i64 u0x0c3ca6cc978e2aae, ; 29: pt-BR/Microsoft.Maui.Controls.resources => 21
	i64 u0x0c3dd9438f54f672, ; 30: lib_Xamarin.GooglePlayServices.Maps.dll.so => 91
	i64 u0x0c59ad9fbbd43abe, ; 31: Mono.Android => 148
	i64 u0x0c7790f60165fc06, ; 32: lib_Microsoft.Maui.Essentials.dll.so => 49
	i64 u0x102a31b45304b1da, ; 33: Xamarin.AndroidX.CustomView => 70
	i64 u0x10f6cfcbcf801616, ; 34: System.IO.Compression.Brotli => 112
	i64 u0x11d2a2a57f14fcae, ; 35: Xamarin.AndroidX.Biometric => 64
	i64 u0x123639456fb056da, ; 36: System.Reflection.Emit.Lightweight.dll => 126
	i64 u0x125b7f94acb989db, ; 37: Xamarin.AndroidX.RecyclerView.dll => 83
	i64 u0x13a01de0cbc3f06c, ; 38: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 8
	i64 u0x13f1e5e209e91af4, ; 39: lib_Java.Interop.dll.so => 146
	i64 u0x13f1e880c25d96d1, ; 40: he/Microsoft.Maui.Controls.resources => 9
	i64 u0x143d8ea60a6a4011, ; 41: Microsoft.Extensions.DependencyInjection.Abstractions => 40
	i64 u0x17125c9a85b4929f, ; 42: lib_netstandard.dll.so => 144
	i64 u0x17b56e25558a5d36, ; 43: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 12
	i64 u0x17f9358913beb16a, ; 44: System.Text.Encodings.Web => 59
	i64 u0x18402a709e357f3b, ; 45: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 95
	i64 u0x18f0ce884e87d89a, ; 46: nb/Microsoft.Maui.Controls.resources.dll => 18
	i64 u0x1a91866a319e9259, ; 47: lib_System.Collections.Concurrent.dll.so => 98
	i64 u0x1aac34d1917ba5d3, ; 48: lib_System.dll.so => 143
	i64 u0x1aad60783ffa3e5b, ; 49: lib-th-Microsoft.Maui.Controls.resources.dll.so => 27
	i64 u0x1c753b5ff15bce1b, ; 50: Mono.Android.Runtime.dll => 147
	i64 u0x1e3d87657e9659bc, ; 51: Xamarin.AndroidX.Navigation.UI => 82
	i64 u0x1e71143913d56c10, ; 52: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 16
	i64 u0x1ed8fcce5e9b50a0, ; 53: Microsoft.Extensions.Options.dll => 43
	i64 u0x209375905fcc1bad, ; 54: lib_System.IO.Compression.Brotli.dll.so => 112
	i64 u0x2174319c0d835bc9, ; 55: System.Runtime => 133
	i64 u0x21cc7e445dcd5469, ; 56: System.Reflection.Emit.ILGeneration => 125
	i64 u0x220fd4f2e7c48170, ; 57: th/Microsoft.Maui.Controls.resources => 27
	i64 u0x2347c268e3e4e536, ; 58: Xamarin.GooglePlayServices.Basement.dll => 90
	i64 u0x237be844f1f812c7, ; 59: System.Threading.Thread.dll => 137
	i64 u0x2407aef2bbe8fadf, ; 60: System.Console => 105
	i64 u0x240abe014b27e7d3, ; 61: Xamarin.AndroidX.Core.dll => 68
	i64 u0x247619fe4413f8bf, ; 62: System.Runtime.Serialization.Primitives.dll => 132
	i64 u0x252073cc3caa62c2, ; 63: fr/Microsoft.Maui.Controls.resources.dll => 8
	i64 u0x2662c629b96b0b30, ; 64: lib_Xamarin.Kotlin.StdLib.dll.so => 93
	i64 u0x268c1439f13bcc29, ; 65: lib_Microsoft.Extensions.Primitives.dll.so => 44
	i64 u0x273f3515de5faf0d, ; 66: id/Microsoft.Maui.Controls.resources.dll => 13
	i64 u0x2742545f9094896d, ; 67: hr/Microsoft.Maui.Controls.resources => 11
	i64 u0x27b410442fad6cf1, ; 68: Java.Interop.dll => 146
	i64 u0x2801845a2c71fbfb, ; 69: System.Net.Primitives.dll => 118
	i64 u0x2a128783efe70ba0, ; 70: uk/Microsoft.Maui.Controls.resources.dll => 29
	i64 u0x2a6507a5ffabdf28, ; 71: System.Diagnostics.TraceSource.dll => 108
	i64 u0x2ad156c8e1354139, ; 72: fi/Microsoft.Maui.Controls.resources => 7
	i64 u0x2af298f63581d886, ; 73: System.Text.RegularExpressions.dll => 136
	i64 u0x2afc1c4f898552ee, ; 74: lib_System.Formats.Asn1.dll.so => 111
	i64 u0x2b148910ed40fbf9, ; 75: zh-Hant/Microsoft.Maui.Controls.resources.dll => 33
	i64 u0x2c8bd14bb93a7d82, ; 76: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 20
	i64 u0x2cc9e1fed6257257, ; 77: lib_System.Reflection.Emit.Lightweight.dll.so => 126
	i64 u0x2cd723e9fe623c7c, ; 78: lib_System.Private.Xml.Linq.dll.so => 123
	i64 u0x2ce03196fe1170d2, ; 79: Microsoft.Maui.Controls.Maps.dll => 46
	i64 u0x2d169d318a968379, ; 80: System.Threading.dll => 138
	i64 u0x2d47774b7d993f59, ; 81: sv/Microsoft.Maui.Controls.resources.dll => 26
	i64 u0x2db915caf23548d2, ; 82: System.Text.Json.dll => 60
	i64 u0x2e6f1f226821322a, ; 83: el/Microsoft.Maui.Controls.resources.dll => 5
	i64 u0x2f2e98e1c89b1aff, ; 84: System.Xml.ReaderWriter => 141
	i64 u0x309ee9eeec09a71e, ; 85: lib_Xamarin.AndroidX.Fragment.dll.so => 72
	i64 u0x30bde19041cd89dd, ; 86: lib_Microsoft.Maui.Maps.dll.so => 51
	i64 u0x31195fef5d8fb552, ; 87: _Microsoft.Android.Resource.Designer.dll => 34
	i64 u0x32243413e774362a, ; 88: Xamarin.AndroidX.CardView.dll => 65
	i64 u0x3235427f8d12dae1, ; 89: lib_System.Drawing.Primitives.dll.so => 109
	i64 u0x329753a17a517811, ; 90: fr/Microsoft.Maui.Controls.resources => 8
	i64 u0x32aa989ff07a84ff, ; 91: lib_System.Xml.ReaderWriter.dll.so => 141
	i64 u0x33a31443733849fe, ; 92: lib-es-Microsoft.Maui.Controls.resources.dll.so => 6
	i64 u0x34dfd74fe2afcf37, ; 93: Microsoft.Maui => 48
	i64 u0x34e292762d9615df, ; 94: cs/Microsoft.Maui.Controls.resources.dll => 2
	i64 u0x3508234247f48404, ; 95: Microsoft.Maui.Controls => 45
	i64 u0x3549870798b4cd30, ; 96: lib_Xamarin.AndroidX.ViewPager2.dll.so => 87
	i64 u0x355282fc1c909694, ; 97: Microsoft.Extensions.Configuration => 37
	i64 u0x36b2b50fdf589ae2, ; 98: System.Reflection.Emit.Lightweight => 126
	i64 u0x374ef46b06791af6, ; 99: System.Reflection.Primitives.dll => 127
	i64 u0x385c17636bb6fe6e, ; 100: Xamarin.AndroidX.CustomView.dll => 70
	i64 u0x393c226616977fdb, ; 101: lib_Xamarin.AndroidX.ViewPager.dll.so => 86
	i64 u0x395b3053dde89e41, ; 102: lib_System.Reactive.dll.so => 58
	i64 u0x395e37c3334cf82a, ; 103: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 1
	i64 u0x39a87563fdb248a0, ; 104: System.Reactive.dll => 58
	i64 u0x39aa39fda111d9d3, ; 105: Newtonsoft.Json => 52
	i64 u0x3b860f9932505633, ; 106: lib_System.Text.Encoding.Extensions.dll.so => 135
	i64 u0x3c7c495f58ac5ee9, ; 107: Xamarin.Kotlin.StdLib => 93
	i64 u0x3d46f0b995082740, ; 108: System.Xml.Linq => 140
	i64 u0x3d9c2a242b040a50, ; 109: lib_Xamarin.AndroidX.Core.dll.so => 68
	i64 u0x3f2839b8d63653b8, ; 110: lib_LiteDB.dll.so => 36
	i64 u0x407a10bb4bf95829, ; 111: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 79
	i64 u0x41cab042be111c34, ; 112: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 63
	i64 u0x43375950ec7c1b6a, ; 113: netstandard.dll => 144
	i64 u0x434c4e1d9284cdae, ; 114: Mono.Android.dll => 148
	i64 u0x43950f84de7cc79a, ; 115: pl/Microsoft.Maui.Controls.resources.dll => 20
	i64 u0x448bd33429269b19, ; 116: Microsoft.CSharp => 97
	i64 u0x4499fa3c8e494654, ; 117: lib_System.Runtime.Serialization.Primitives.dll.so => 132
	i64 u0x4515080865a951a5, ; 118: Xamarin.Kotlin.StdLib.dll => 93
	i64 u0x45c40276a42e283e, ; 119: System.Diagnostics.TraceSource => 108
	i64 u0x46a4213bc97fe5ae, ; 120: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 24
	i64 u0x47358bd471172e1d, ; 121: lib_System.Xml.Linq.dll.so => 140
	i64 u0x47daf4e1afbada10, ; 122: pt/Microsoft.Maui.Controls.resources => 22
	i64 u0x49e952f19a4e2022, ; 123: System.ObjectModel => 121
	i64 u0x4a5667b2462a664b, ; 124: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 82
	i64 u0x4b7b6532ded934b7, ; 125: System.Text.Json => 60
	i64 u0x4c9caee94c082049, ; 126: Xamarin.GooglePlayServices.Maps => 91
	i64 u0x4cc5f15266470798, ; 127: lib_Xamarin.AndroidX.Loader.dll.so => 78
	i64 u0x4d479f968a05e504, ; 128: System.Linq.Expressions.dll => 114
	i64 u0x4d55a010ffc4faff, ; 129: System.Private.Xml => 124
	i64 u0x4d95fccc1f67c7ca, ; 130: System.Runtime.Loader.dll => 129
	i64 u0x4dcf44c3c9b076a2, ; 131: it/Microsoft.Maui.Controls.resources.dll => 14
	i64 u0x4dd9247f1d2c3235, ; 132: Xamarin.AndroidX.Loader.dll => 78
	i64 u0x4e32f00cb0937401, ; 133: Mono.Android.Runtime => 147
	i64 u0x4f21ee6ef9eb527e, ; 134: ca/Microsoft.Maui.Controls.resources => 1
	i64 u0x5037f0be3c28c7a3, ; 135: lib_Microsoft.Maui.Controls.dll.so => 45
	i64 u0x5131bbe80989093f, ; 136: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 76
	i64 u0x51bb8a2afe774e32, ; 137: System.Drawing => 110
	i64 u0x526ce79eb8e90527, ; 138: lib_System.Net.Primitives.dll.so => 118
	i64 u0x52829f00b4467c38, ; 139: lib_System.Data.Common.dll.so => 106
	i64 u0x529ffe06f39ab8db, ; 140: Xamarin.AndroidX.Core => 68
	i64 u0x52ff996554dbf352, ; 141: Microsoft.Maui.Graphics => 50
	i64 u0x535f7e40e8fef8af, ; 142: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 25
	i64 u0x53c3014b9437e684, ; 143: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 31
	i64 u0x54795225dd1587af, ; 144: lib_System.Runtime.dll.so => 133
	i64 u0x547a34f14e5f6210, ; 145: Xamarin.AndroidX.Lifecycle.Common.dll => 73
	i64 u0x556e8b63b660ab8b, ; 146: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 74
	i64 u0x5588627c9a108ec9, ; 147: System.Collections.Specialized => 100
	i64 u0x571c5cfbec5ae8e2, ; 148: System.Private.Uri => 122
	i64 u0x578cd35c91d7b347, ; 149: lib_SQLitePCLRaw.core.dll.so => 55
	i64 u0x579a06fed6eec900, ; 150: System.Private.CoreLib.dll => 145
	i64 u0x57c542c14049b66d, ; 151: System.Diagnostics.DiagnosticSource => 107
	i64 u0x58601b2dda4a27b9, ; 152: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 15
	i64 u0x58688d9af496b168, ; 153: Microsoft.Extensions.DependencyInjection.dll => 39
	i64 u0x595a356d23e8da9a, ; 154: lib_Microsoft.CSharp.dll.so => 97
	i64 u0x5a89a886ae30258d, ; 155: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 67
	i64 u0x5a8f6699f4a1caa9, ; 156: lib_System.Threading.dll.so => 138
	i64 u0x5ae9cd33b15841bf, ; 157: System.ComponentModel => 104
	i64 u0x5b5f0e240a06a2a2, ; 158: da/Microsoft.Maui.Controls.resources.dll => 3
	i64 u0x5b755276902c8414, ; 159: Xamarin.GooglePlayServices.Base => 89
	i64 u0x5c393624b8176517, ; 160: lib_Microsoft.Extensions.Logging.dll.so => 41
	i64 u0x5c9275c2a8f9191d, ; 161: Projekt_c4 => 96
	i64 u0x5db0cbbd1028510e, ; 162: lib_System.Runtime.InteropServices.dll.so => 128
	i64 u0x5db30905d3e5013b, ; 163: Xamarin.AndroidX.Collection.Jvm.dll => 66
	i64 u0x5e467bc8f09ad026, ; 164: System.Collections.Specialized.dll => 100
	i64 u0x5ea92fdb19ec8c4c, ; 165: System.Text.Encodings.Web.dll => 59
	i64 u0x5eb8046dd40e9ac3, ; 166: System.ComponentModel.Primitives => 102
	i64 u0x5f36ccf5c6a57e24, ; 167: System.Xml.ReaderWriter.dll => 141
	i64 u0x5f4294b9b63cb842, ; 168: System.Data.Common => 106
	i64 u0x5f9a2d823f664957, ; 169: lib-el-Microsoft.Maui.Controls.resources.dll.so => 5
	i64 u0x609f4b7b63d802d4, ; 170: lib_Microsoft.Extensions.DependencyInjection.dll.so => 39
	i64 u0x60cd4e33d7e60134, ; 171: Xamarin.KotlinX.Coroutines.Core.Jvm => 94
	i64 u0x60f62d786afcf130, ; 172: System.Memory => 116
	i64 u0x61be8d1299194243, ; 173: Microsoft.Maui.Controls.Xaml => 47
	i64 u0x61d2cba29557038f, ; 174: de/Microsoft.Maui.Controls.resources => 4
	i64 u0x61d88f399afb2f45, ; 175: lib_System.Runtime.Loader.dll.so => 129
	i64 u0x622eef6f9e59068d, ; 176: System.Private.CoreLib => 145
	i64 u0x6400f68068c1e9f1, ; 177: Xamarin.Google.Android.Material.dll => 88
	i64 u0x65ecac39144dd3cc, ; 178: Microsoft.Maui.Controls.dll => 45
	i64 u0x65ece51227bfa724, ; 179: lib_System.Runtime.Numerics.dll.so => 130
	i64 u0x6692e924eade1b29, ; 180: lib_System.Console.dll.so => 105
	i64 u0x66a4e5c6a3fb0bae, ; 181: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 76
	i64 u0x66d13304ce1a3efa, ; 182: Xamarin.AndroidX.CursorAdapter => 69
	i64 u0x68558ec653afa616, ; 183: lib-da-Microsoft.Maui.Controls.resources.dll.so => 3
	i64 u0x6872ec7a2e36b1ac, ; 184: System.Drawing.Primitives.dll => 109
	i64 u0x68fbbbe2eb455198, ; 185: System.Formats.Asn1 => 111
	i64 u0x69063fc0ba8e6bdd, ; 186: he/Microsoft.Maui.Controls.resources.dll => 9
	i64 u0x6a4d7577b2317255, ; 187: System.Runtime.InteropServices.dll => 128
	i64 u0x6ab05716e0ac384b, ; 188: LiteDB.dll => 36
	i64 u0x6ace3b74b15ee4a4, ; 189: nb/Microsoft.Maui.Controls.resources => 18
	i64 u0x6bc3b6f99d05be4b, ; 190: lib_Projekt_c4.dll.so => 96
	i64 u0x6c07f7c8a4a1e99d, ; 191: LiteDB => 36
	i64 u0x6c0fad39f1ea366b, ; 192: Plugin.Fingerprint.dll => 53
	i64 u0x6d12bfaa99c72b1f, ; 193: lib_Microsoft.Maui.Graphics.dll.so => 50
	i64 u0x6d79993361e10ef2, ; 194: Microsoft.Extensions.Primitives => 44
	i64 u0x6d86d56b84c8eb71, ; 195: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 69
	i64 u0x6d9bea6b3e895cf7, ; 196: Microsoft.Extensions.Primitives.dll => 44
	i64 u0x6e25a02c3833319a, ; 197: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 80
	i64 u0x6fd2265da78b93a4, ; 198: lib_Microsoft.Maui.dll.so => 48
	i64 u0x6fdfc7de82c33008, ; 199: cs/Microsoft.Maui.Controls.resources => 2
	i64 u0x70e99f48c05cb921, ; 200: tr/Microsoft.Maui.Controls.resources.dll => 28
	i64 u0x70fd3deda22442d2, ; 201: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 18
	i64 u0x71a495ea3761dde8, ; 202: lib-it-Microsoft.Maui.Controls.resources.dll.so => 14
	i64 u0x71ad672adbe48f35, ; 203: System.ComponentModel.Primitives.dll => 102
	i64 u0x72b1fb4109e08d7b, ; 204: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 11
	i64 u0x73e4ce94e2eb6ffc, ; 205: lib_System.Memory.dll.so => 116
	i64 u0x755a91767330b3d4, ; 206: lib_Microsoft.Extensions.Configuration.dll.so => 37
	i64 u0x76012e7334db86e5, ; 207: lib_Xamarin.AndroidX.SavedState.dll.so => 84
	i64 u0x76ca07b878f44da0, ; 208: System.Runtime.Numerics.dll => 130
	i64 u0x780bc73597a503a9, ; 209: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 17
	i64 u0x783606d1e53e7a1a, ; 210: th/Microsoft.Maui.Controls.resources.dll => 27
	i64 u0x78a45e51311409b6, ; 211: Xamarin.AndroidX.Fragment.dll => 72
	i64 u0x7adb8da2ac89b647, ; 212: fi/Microsoft.Maui.Controls.resources.dll => 7
	i64 u0x7bef86a4335c4870, ; 213: System.ComponentModel.TypeConverter => 103
	i64 u0x7c0820144cd34d6a, ; 214: sk/Microsoft.Maui.Controls.resources.dll => 25
	i64 u0x7c2a0bd1e0f988fc, ; 215: lib-de-Microsoft.Maui.Controls.resources.dll.so => 4
	i64 u0x7cb95ad2a929d044, ; 216: Xamarin.GooglePlayServices.Basement => 90
	i64 u0x7d649b75d580bb42, ; 217: ms/Microsoft.Maui.Controls.resources.dll => 17
	i64 u0x7d8ee2bdc8e3aad1, ; 218: System.Numerics.Vectors => 120
	i64 u0x7dfc3d6d9d8d7b70, ; 219: System.Collections => 101
	i64 u0x7e946809d6008ef2, ; 220: lib_System.ObjectModel.dll.so => 121
	i64 u0x7eb4f0dc47488736, ; 221: lib_Xamarin.GooglePlayServices.Tasks.dll.so => 92
	i64 u0x7ecc13347c8fd849, ; 222: lib_System.ComponentModel.dll.so => 104
	i64 u0x7f00ddd9b9ca5a13, ; 223: Xamarin.AndroidX.ViewPager.dll => 86
	i64 u0x7f9351cd44b1273f, ; 224: Microsoft.Extensions.Configuration.Abstractions => 38
	i64 u0x7fbd557c99b3ce6f, ; 225: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 75
	i64 u0x80fa55b6d1b0be99, ; 226: SQLitePCLRaw.provider.e_sqlite3 => 56
	i64 u0x812c069d5cdecc17, ; 227: System.dll => 143
	i64 u0x81ab745f6c0f5ce6, ; 228: zh-Hant/Microsoft.Maui.Controls.resources => 33
	i64 u0x8277f2be6b5ce05f, ; 229: Xamarin.AndroidX.AppCompat => 62
	i64 u0x828f06563b30bc50, ; 230: lib_Xamarin.AndroidX.CardView.dll.so => 65
	i64 u0x82df8f5532a10c59, ; 231: lib_System.Drawing.dll.so => 110
	i64 u0x82f6403342e12049, ; 232: uk/Microsoft.Maui.Controls.resources => 29
	i64 u0x83144699b312ad81, ; 233: SQLite-net.dll => 54
	i64 u0x83c14ba66c8e2b8c, ; 234: zh-Hans/Microsoft.Maui.Controls.resources => 32
	i64 u0x86a909228dc7657b, ; 235: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 33
	i64 u0x86b3e00c36b84509, ; 236: Microsoft.Extensions.Configuration.dll => 37
	i64 u0x87c69b87d9283884, ; 237: lib_System.Threading.Thread.dll.so => 137
	i64 u0x87f6569b25707834, ; 238: System.IO.Compression.Brotli.dll => 112
	i64 u0x8842b3a5d2d3fb36, ; 239: Microsoft.Maui.Essentials => 49
	i64 u0x88bda98e0cffb7a9, ; 240: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 94
	i64 u0x8930322c7bd8f768, ; 241: netstandard => 144
	i64 u0x897a606c9e39c75f, ; 242: lib_System.ComponentModel.Primitives.dll.so => 102
	i64 u0x8ad229ea26432ee2, ; 243: Xamarin.AndroidX.Loader => 78
	i64 u0x8b4ff5d0fdd5faa1, ; 244: lib_System.Diagnostics.DiagnosticSource.dll.so => 107
	i64 u0x8b9ceca7acae3451, ; 245: lib-he-Microsoft.Maui.Controls.resources.dll.so => 9
	i64 u0x8d0f420977c2c1c7, ; 246: Xamarin.AndroidX.CursorAdapter.dll => 69
	i64 u0x8d7b8ab4b3310ead, ; 247: System.Threading => 138
	i64 u0x8da188285aadfe8e, ; 248: System.Collections.Concurrent => 98
	i64 u0x8ec6e06a61c1baeb, ; 249: lib_Newtonsoft.Json.dll.so => 52
	i64 u0x8ed807bfe9858dfc, ; 250: Xamarin.AndroidX.Navigation.Common => 79
	i64 u0x8ee08b8194a30f48, ; 251: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 10
	i64 u0x8ef7601039857a44, ; 252: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 23
	i64 u0x8ef9414937d93a0a, ; 253: SQLitePCLRaw.core.dll => 55
	i64 u0x8efbc0801a122264, ; 254: Xamarin.GooglePlayServices.Tasks.dll => 92
	i64 u0x8f32c6f611f6ffab, ; 255: pt/Microsoft.Maui.Controls.resources.dll => 22
	i64 u0x8f8829d21c8985a4, ; 256: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 21
	i64 u0x8fd27d934d7b3a55, ; 257: SQLitePCLRaw.core => 55
	i64 u0x90263f8448b8f572, ; 258: lib_System.Diagnostics.TraceSource.dll.so => 108
	i64 u0x903101b46fb73a04, ; 259: _Microsoft.Android.Resource.Designer => 34
	i64 u0x90393bd4865292f3, ; 260: lib_System.IO.Compression.dll.so => 113
	i64 u0x90634f86c5ebe2b5, ; 261: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 76
	i64 u0x907b636704ad79ef, ; 262: lib_Microsoft.Maui.Controls.Xaml.dll.so => 47
	i64 u0x91418dc638b29e68, ; 263: lib_Xamarin.AndroidX.CustomView.dll.so => 70
	i64 u0x9157bd523cd7ed36, ; 264: lib_System.Text.Json.dll.so => 60
	i64 u0x91a74f07b30d37e2, ; 265: System.Linq.dll => 115
	i64 u0x91fa41a87223399f, ; 266: ca/Microsoft.Maui.Controls.resources.dll => 1
	i64 u0x9388aad9b7ae40ce, ; 267: lib_Xamarin.AndroidX.Lifecycle.Common.dll.so => 73
	i64 u0x93cfa73ab28d6e35, ; 268: ms/Microsoft.Maui.Controls.resources => 17
	i64 u0x944077d8ca3c6580, ; 269: System.IO.Compression.dll => 113
	i64 u0x967fc325e09bfa8c, ; 270: es/Microsoft.Maui.Controls.resources => 6
	i64 u0x9732d8dbddea3d9a, ; 271: id/Microsoft.Maui.Controls.resources => 13
	i64 u0x978be80e5210d31b, ; 272: Microsoft.Maui.Graphics.dll => 50
	i64 u0x979ab54025cc1c7f, ; 273: lib_Xamarin.GooglePlayServices.Base.dll.so => 89
	i64 u0x97b8c771ea3e4220, ; 274: System.ComponentModel.dll => 104
	i64 u0x97e144c9d3c6976e, ; 275: System.Collections.Concurrent.dll => 98
	i64 u0x991d510397f92d9d, ; 276: System.Linq.Expressions => 114
	i64 u0x99a00ca5270c6878, ; 277: Xamarin.AndroidX.Navigation.Runtime => 81
	i64 u0x99cdc6d1f2d3a72f, ; 278: ko/Microsoft.Maui.Controls.resources.dll => 16
	i64 u0x9d5dbcf5a48583fe, ; 279: lib_Xamarin.AndroidX.Activity.dll.so => 61
	i64 u0x9d74dee1a7725f34, ; 280: Microsoft.Extensions.Configuration.Abstractions.dll => 38
	i64 u0x9e4534b6adaf6e84, ; 281: nl/Microsoft.Maui.Controls.resources => 19
	i64 u0x9eaf1efdf6f7267e, ; 282: Xamarin.AndroidX.Navigation.Common.dll => 79
	i64 u0x9ef542cf1f78c506, ; 283: Xamarin.AndroidX.Lifecycle.LiveData.Core => 75
	i64 u0xa0d8259f4cc284ec, ; 284: lib_System.Security.Cryptography.dll.so => 134
	i64 u0xa1440773ee9d341e, ; 285: Xamarin.Google.Android.Material => 88
	i64 u0xa1a184e02d8fa4f2, ; 286: Firebase.dll => 35
	i64 u0xa1b9d7c27f47219f, ; 287: Xamarin.AndroidX.Navigation.UI.dll => 82
	i64 u0xa2572680829d2c7c, ; 288: System.IO.Pipelines.dll => 57
	i64 u0xa46aa1eaa214539b, ; 289: ko/Microsoft.Maui.Controls.resources => 16
	i64 u0xa4edc8f2ceae241a, ; 290: System.Data.Common.dll => 106
	i64 u0xa5494f40f128ce6a, ; 291: System.Runtime.Serialization.Formatters.dll => 131
	i64 u0xa5e599d1e0524750, ; 292: System.Numerics.Vectors.dll => 120
	i64 u0xa5f1ba49b85dd355, ; 293: System.Security.Cryptography.dll => 134
	i64 u0xa67dbee13e1df9ca, ; 294: Xamarin.AndroidX.SavedState.dll => 84
	i64 u0xa68a420042bb9b1f, ; 295: Xamarin.AndroidX.DrawerLayout.dll => 71
	i64 u0xa78ce3745383236a, ; 296: Xamarin.AndroidX.Lifecycle.Common.Jvm => 74
	i64 u0xa7c31b56b4dc7b33, ; 297: hu/Microsoft.Maui.Controls.resources => 12
	i64 u0xa843f6095f0d247d, ; 298: Xamarin.GooglePlayServices.Base.dll => 89
	i64 u0xaa2219c8e3449ff5, ; 299: Microsoft.Extensions.Logging.Abstractions => 42
	i64 u0xaa443ac34067eeef, ; 300: System.Private.Xml.dll => 124
	i64 u0xaa52de307ef5d1dd, ; 301: System.Net.Http => 117
	i64 u0xaaaf86367285a918, ; 302: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 40
	i64 u0xaaf84bb3f052a265, ; 303: el/Microsoft.Maui.Controls.resources => 5
	i64 u0xab9c1b2687d86b0b, ; 304: lib_System.Linq.Expressions.dll.so => 114
	i64 u0xac2af3fa195a15ce, ; 305: System.Runtime.Numerics => 130
	i64 u0xac5376a2a538dc10, ; 306: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 75
	i64 u0xac98d31068e24591, ; 307: System.Xml.XDocument => 142
	i64 u0xacd46e002c3ccb97, ; 308: ro/Microsoft.Maui.Controls.resources => 23
	i64 u0xad89c07347f1bad6, ; 309: nl/Microsoft.Maui.Controls.resources.dll => 19
	i64 u0xadbb53caf78a79d2, ; 310: System.Web.HttpUtility => 139
	i64 u0xadc90ab061a9e6e4, ; 311: System.ComponentModel.TypeConverter.dll => 103
	i64 u0xae282bcd03739de7, ; 312: Java.Interop => 146
	i64 u0xae53579c90db1107, ; 313: System.ObjectModel.dll => 121
	i64 u0xae7ea18c61eef394, ; 314: SQLite-net => 54
	i64 u0xafe29f45095518e7, ; 315: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 77
	i64 u0xb05cc42cd94c6d9d, ; 316: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 26
	i64 u0xb220631954820169, ; 317: System.Text.RegularExpressions => 136
	i64 u0xb2a3f67f3bf29fce, ; 318: da/Microsoft.Maui.Controls.resources => 3
	i64 u0xb3f0a0fcda8d3ebc, ; 319: Xamarin.AndroidX.CardView => 65
	i64 u0xb46be1aa6d4fff93, ; 320: hi/Microsoft.Maui.Controls.resources => 10
	i64 u0xb477491be13109d8, ; 321: ar/Microsoft.Maui.Controls.resources => 0
	i64 u0xb4bd7015ecee9d86, ; 322: System.IO.Pipelines => 57
	i64 u0xb5c7fcdafbc67ee4, ; 323: Microsoft.Extensions.Logging.Abstractions.dll => 42
	i64 u0xb7212c4683a94afe, ; 324: System.Drawing.Primitives => 109
	i64 u0xb7b7753d1f319409, ; 325: sv/Microsoft.Maui.Controls.resources => 26
	i64 u0xb81a2c6e0aee50fe, ; 326: lib_System.Private.CoreLib.dll.so => 145
	i64 u0xb9185c33a1643eed, ; 327: Microsoft.CSharp.dll => 97
	i64 u0xb9b19a3eb1924681, ; 328: lib_Microsoft.Maui.Controls.Maps.dll.so => 46
	i64 u0xb9f64d3b230def68, ; 329: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 22
	i64 u0xb9fc3c8a556e3691, ; 330: ja/Microsoft.Maui.Controls.resources => 15
	i64 u0xba4670aa94a2b3c6, ; 331: lib_System.Xml.XDocument.dll.so => 142
	i64 u0xba48785529705af9, ; 332: System.Collections.dll => 101
	i64 u0xbbd180354b67271a, ; 333: System.Runtime.Serialization.Formatters => 131
	i64 u0xbc1c174a8f6053a0, ; 334: Plugin.Fingerprint => 53
	i64 u0xbc22a245dab70cb4, ; 335: lib_SQLitePCLRaw.provider.e_sqlite3.dll.so => 56
	i64 u0xbd0e2c0d55246576, ; 336: System.Net.Http.dll => 117
	i64 u0xbd437a2cdb333d0d, ; 337: Xamarin.AndroidX.ViewPager2 => 87
	i64 u0xbee38d4a88835966, ; 338: Xamarin.AndroidX.AppCompat.AppCompatResources => 63
	i64 u0xc040a4ab55817f58, ; 339: ar/Microsoft.Maui.Controls.resources.dll => 0
	i64 u0xc0d928351ab5ca77, ; 340: System.Console.dll => 105
	i64 u0xc12b8b3afa48329c, ; 341: lib_System.Linq.dll.so => 115
	i64 u0xc1ff9ae3cdb6e1e6, ; 342: Xamarin.AndroidX.Activity.dll => 61
	i64 u0xc28c50f32f81cc73, ; 343: ja/Microsoft.Maui.Controls.resources.dll => 15
	i64 u0xc2bcfec99f69365e, ; 344: Xamarin.AndroidX.ViewPager2.dll => 87
	i64 u0xc4d3858ed4d08512, ; 345: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 77
	i64 u0xc50fded0ded1418c, ; 346: lib_System.ComponentModel.TypeConverter.dll.so => 103
	i64 u0xc519125d6bc8fb11, ; 347: lib_System.Net.Requests.dll.so => 119
	i64 u0xc5293b19e4dc230e, ; 348: Xamarin.AndroidX.Navigation.Fragment => 80
	i64 u0xc5325b2fcb37446f, ; 349: lib_System.Private.Xml.dll.so => 124
	i64 u0xc5a0f4b95a699af7, ; 350: lib_System.Private.Uri.dll.so => 122
	i64 u0xc64f6952cef5d09f, ; 351: Microsoft.Maui.Maps.dll => 51
	i64 u0xc68e480c8069e1f7, ; 352: Microsoft.Maui.Maps => 51
	i64 u0xc7c01e7d7c93a110, ; 353: System.Text.Encoding.Extensions.dll => 135
	i64 u0xc7ce851898a4548e, ; 354: lib_System.Web.HttpUtility.dll.so => 139
	i64 u0xc858a28d9ee5a6c5, ; 355: lib_System.Collections.Specialized.dll.so => 100
	i64 u0xca3a723e7342c5b6, ; 356: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 28
	i64 u0xcab3493c70141c2d, ; 357: pl/Microsoft.Maui.Controls.resources => 20
	i64 u0xcacfddc9f7c6de76, ; 358: ro/Microsoft.Maui.Controls.resources.dll => 23
	i64 u0xcb76efab0f56f81a, ; 359: System.Reactive => 58
	i64 u0xcbd4fdd9cef4a294, ; 360: lib__Microsoft.Android.Resource.Designer.dll.so => 34
	i64 u0xcc2876b32ef2794c, ; 361: lib_System.Text.RegularExpressions.dll.so => 136
	i64 u0xcc5c3bb714c4561e, ; 362: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 94
	i64 u0xcc76886e09b88260, ; 363: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 95
	i64 u0xccf25c4b634ccd3a, ; 364: zh-Hans/Microsoft.Maui.Controls.resources.dll => 32
	i64 u0xcd10a42808629144, ; 365: System.Net.Requests => 119
	i64 u0xcdd0c48b6937b21c, ; 366: Xamarin.AndroidX.SwipeRefreshLayout => 85
	i64 u0xce57238a2f68613f, ; 367: lib_Plugin.Fingerprint.dll.so => 53
	i64 u0xcf23d8093f3ceadf, ; 368: System.Diagnostics.DiagnosticSource.dll => 107
	i64 u0xcf8fc898f98b0d34, ; 369: System.Private.Xml.Linq => 123
	i64 u0xcfb21487d9cb358b, ; 370: Xamarin.GooglePlayServices.Maps.dll => 91
	i64 u0xd1194e1d8a8de83c, ; 371: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 74
	i64 u0xd333d0af9e423810, ; 372: System.Runtime.InteropServices => 128
	i64 u0xd3426d966bb704f5, ; 373: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 63
	i64 u0xd3651b6fc3125825, ; 374: System.Private.Uri.dll => 122
	i64 u0xd373685349b1fe8b, ; 375: Microsoft.Extensions.Logging.dll => 41
	i64 u0xd3e4c8d6a2d5d470, ; 376: it/Microsoft.Maui.Controls.resources => 14
	i64 u0xd4645626dffec99d, ; 377: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 40
	i64 u0xd5507e11a2b2839f, ; 378: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 77
	i64 u0xd6694f8359737e4e, ; 379: Xamarin.AndroidX.SavedState => 84
	i64 u0xd6d21782156bc35b, ; 380: Xamarin.AndroidX.SwipeRefreshLayout.dll => 85
	i64 u0xd72329819cbbbc44, ; 381: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 38
	i64 u0xd7b3764ada9d341d, ; 382: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 42
	i64 u0xda1dfa4c534a9251, ; 383: Microsoft.Extensions.DependencyInjection => 39
	i64 u0xdad05a11827959a3, ; 384: System.Collections.NonGeneric.dll => 99
	i64 u0xdb5383ab5865c007, ; 385: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 30
	i64 u0xdb58816721c02a59, ; 386: lib_System.Reflection.Emit.ILGeneration.dll.so => 125
	i64 u0xdbeda89f832aa805, ; 387: vi/Microsoft.Maui.Controls.resources.dll => 30
	i64 u0xdbf9607a441b4505, ; 388: System.Linq => 115
	i64 u0xdce2c53525640bf3, ; 389: Microsoft.Extensions.Logging => 41
	i64 u0xdd2b722d78ef5f43, ; 390: System.Runtime.dll => 133
	i64 u0xdd67031857c72f96, ; 391: lib_System.Text.Encodings.Web.dll.so => 59
	i64 u0xdde30e6b77aa6f6c, ; 392: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 32
	i64 u0xde110ae80fa7c2e2, ; 393: System.Xml.XDocument.dll => 142
	i64 u0xde8769ebda7d8647, ; 394: hr/Microsoft.Maui.Controls.resources.dll => 11
	i64 u0xe0142572c095a480, ; 395: Xamarin.AndroidX.AppCompat.dll => 62
	i64 u0xe02f89350ec78051, ; 396: Xamarin.AndroidX.CoordinatorLayout.dll => 67
	i64 u0xe0a0a4c883f4beeb, ; 397: lib_Xamarin.AndroidX.Biometric.dll.so => 64
	i64 u0xe192a588d4410686, ; 398: lib_System.IO.Pipelines.dll.so => 57
	i64 u0xe1a08bd3fa539e0d, ; 399: System.Runtime.Loader => 129
	i64 u0xe1b52f9f816c70ef, ; 400: System.Private.Xml.Linq.dll => 123
	i64 u0xe2420585aeceb728, ; 401: System.Net.Requests.dll => 119
	i64 u0xe29b73bc11392966, ; 402: lib-id-Microsoft.Maui.Controls.resources.dll.so => 13
	i64 u0xe3811d68d4fe8463, ; 403: pt-BR/Microsoft.Maui.Controls.resources.dll => 21
	i64 u0xe3a586956771a0ed, ; 404: lib_SQLite-net.dll.so => 54
	i64 u0xe494f7ced4ecd10a, ; 405: hu/Microsoft.Maui.Controls.resources.dll => 12
	i64 u0xe4a9b1e40d1e8917, ; 406: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 7
	i64 u0xe4f74a0b5bf9703f, ; 407: System.Runtime.Serialization.Primitives => 132
	i64 u0xe5434e8a119ceb69, ; 408: lib_Mono.Android.dll.so => 148
	i64 u0xe89a2a9ef110899b, ; 409: System.Drawing.dll => 110
	i64 u0xedc632067fb20ff3, ; 410: System.Memory.dll => 116
	i64 u0xedc8e4ca71a02a8b, ; 411: Xamarin.AndroidX.Navigation.Runtime.dll => 81
	i64 u0xee27c952ed6d058b, ; 412: Microsoft.Maui.Controls.Maps => 46
	i64 u0xeeb7ebb80150501b, ; 413: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 66
	i64 u0xeedf6bb58bca9075, ; 414: Xamarin.AndroidX.Biometric.dll => 64
	i64 u0xef72742e1bcca27a, ; 415: Microsoft.Maui.Essentials.dll => 49
	i64 u0xefec0b7fdc57ec42, ; 416: Xamarin.AndroidX.Activity => 61
	i64 u0xf00c29406ea45e19, ; 417: es/Microsoft.Maui.Controls.resources.dll => 6
	i64 u0xf11b621fc87b983f, ; 418: Microsoft.Maui.Controls.Xaml.dll => 47
	i64 u0xf1c4b4005493d871, ; 419: System.Formats.Asn1.dll => 111
	i64 u0xf238bd79489d3a96, ; 420: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 19
	i64 u0xf37221fda4ef8830, ; 421: lib_Xamarin.Google.Android.Material.dll.so => 88
	i64 u0xf3ddfe05336abf29, ; 422: System => 143
	i64 u0xf408654b2a135055, ; 423: System.Reflection.Emit.ILGeneration.dll => 125
	i64 u0xf4c1dd70a5496a17, ; 424: System.IO.Compression => 113
	i64 u0xf6077741019d7428, ; 425: Xamarin.AndroidX.CoordinatorLayout => 67
	i64 u0xf77b20923f07c667, ; 426: de/Microsoft.Maui.Controls.resources.dll => 4
	i64 u0xf7e2cac4c45067b3, ; 427: lib_System.Numerics.Vectors.dll.so => 120
	i64 u0xf7e74930e0e3d214, ; 428: zh-HK/Microsoft.Maui.Controls.resources.dll => 31
	i64 u0xf7fa0bf77fe677cc, ; 429: Newtonsoft.Json.dll => 52
	i64 u0xf84773b5c81e3cef, ; 430: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 29
	i64 u0xf84bc13af9296b71, ; 431: Firebase => 35
	i64 u0xf8b77539b362d3ba, ; 432: lib_System.Reflection.Primitives.dll.so => 127
	i64 u0xf8e045dc345b2ea3, ; 433: lib_Xamarin.AndroidX.RecyclerView.dll.so => 83
	i64 u0xf915dc29808193a1, ; 434: System.Web.HttpUtility.dll => 139
	i64 u0xf96c777a2a0686f4, ; 435: hi/Microsoft.Maui.Controls.resources.dll => 10
	i64 u0xf9eec5bb3a6aedc6, ; 436: Microsoft.Extensions.Options => 43
	i64 u0xfa5ed7226d978949, ; 437: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 0
	i64 u0xfa645d91e9fc4cba, ; 438: System.Threading.Thread => 137
	i64 u0xfbf0a31c9fc34bc4, ; 439: lib_System.Net.Http.dll.so => 117
	i64 u0xfc6b7527cc280b3f, ; 440: lib_System.Runtime.Serialization.Formatters.dll.so => 131
	i64 u0xfc719aec26adf9d9, ; 441: Xamarin.AndroidX.Navigation.Fragment.dll => 80
	i64 u0xfd22f00870e40ae0, ; 442: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 71
	i64 u0xfd536c702f64dc47, ; 443: System.Text.Encoding.Extensions => 135
	i64 u0xfd583f7657b6a1cb, ; 444: Xamarin.AndroidX.Fragment => 72
	i64 u0xfddbe9695626a7f5, ; 445: Xamarin.AndroidX.Lifecycle.Common => 73
	i64 u0xfeae9952cf03b8cb ; 446: tr/Microsoft.Maui.Controls.resources => 28
], align 16

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [447 x i32] [
	i32 85, i32 81, i32 147, i32 62, i32 56, i32 24, i32 2, i32 30,
	i32 118, i32 92, i32 83, i32 101, i32 48, i32 31, i32 140, i32 66,
	i32 96, i32 24, i32 99, i32 127, i32 71, i32 43, i32 99, i32 90,
	i32 134, i32 35, i32 25, i32 95, i32 86, i32 21, i32 91, i32 148,
	i32 49, i32 70, i32 112, i32 64, i32 126, i32 83, i32 8, i32 146,
	i32 9, i32 40, i32 144, i32 12, i32 59, i32 95, i32 18, i32 98,
	i32 143, i32 27, i32 147, i32 82, i32 16, i32 43, i32 112, i32 133,
	i32 125, i32 27, i32 90, i32 137, i32 105, i32 68, i32 132, i32 8,
	i32 93, i32 44, i32 13, i32 11, i32 146, i32 118, i32 29, i32 108,
	i32 7, i32 136, i32 111, i32 33, i32 20, i32 126, i32 123, i32 46,
	i32 138, i32 26, i32 60, i32 5, i32 141, i32 72, i32 51, i32 34,
	i32 65, i32 109, i32 8, i32 141, i32 6, i32 48, i32 2, i32 45,
	i32 87, i32 37, i32 126, i32 127, i32 70, i32 86, i32 58, i32 1,
	i32 58, i32 52, i32 135, i32 93, i32 140, i32 68, i32 36, i32 79,
	i32 63, i32 144, i32 148, i32 20, i32 97, i32 132, i32 93, i32 108,
	i32 24, i32 140, i32 22, i32 121, i32 82, i32 60, i32 91, i32 78,
	i32 114, i32 124, i32 129, i32 14, i32 78, i32 147, i32 1, i32 45,
	i32 76, i32 110, i32 118, i32 106, i32 68, i32 50, i32 25, i32 31,
	i32 133, i32 73, i32 74, i32 100, i32 122, i32 55, i32 145, i32 107,
	i32 15, i32 39, i32 97, i32 67, i32 138, i32 104, i32 3, i32 89,
	i32 41, i32 96, i32 128, i32 66, i32 100, i32 59, i32 102, i32 141,
	i32 106, i32 5, i32 39, i32 94, i32 116, i32 47, i32 4, i32 129,
	i32 145, i32 88, i32 45, i32 130, i32 105, i32 76, i32 69, i32 3,
	i32 109, i32 111, i32 9, i32 128, i32 36, i32 18, i32 96, i32 36,
	i32 53, i32 50, i32 44, i32 69, i32 44, i32 80, i32 48, i32 2,
	i32 28, i32 18, i32 14, i32 102, i32 11, i32 116, i32 37, i32 84,
	i32 130, i32 17, i32 27, i32 72, i32 7, i32 103, i32 25, i32 4,
	i32 90, i32 17, i32 120, i32 101, i32 121, i32 92, i32 104, i32 86,
	i32 38, i32 75, i32 56, i32 143, i32 33, i32 62, i32 65, i32 110,
	i32 29, i32 54, i32 32, i32 33, i32 37, i32 137, i32 112, i32 49,
	i32 94, i32 144, i32 102, i32 78, i32 107, i32 9, i32 69, i32 138,
	i32 98, i32 52, i32 79, i32 10, i32 23, i32 55, i32 92, i32 22,
	i32 21, i32 55, i32 108, i32 34, i32 113, i32 76, i32 47, i32 70,
	i32 60, i32 115, i32 1, i32 73, i32 17, i32 113, i32 6, i32 13,
	i32 50, i32 89, i32 104, i32 98, i32 114, i32 81, i32 16, i32 61,
	i32 38, i32 19, i32 79, i32 75, i32 134, i32 88, i32 35, i32 82,
	i32 57, i32 16, i32 106, i32 131, i32 120, i32 134, i32 84, i32 71,
	i32 74, i32 12, i32 89, i32 42, i32 124, i32 117, i32 40, i32 5,
	i32 114, i32 130, i32 75, i32 142, i32 23, i32 19, i32 139, i32 103,
	i32 146, i32 121, i32 54, i32 77, i32 26, i32 136, i32 3, i32 65,
	i32 10, i32 0, i32 57, i32 42, i32 109, i32 26, i32 145, i32 97,
	i32 46, i32 22, i32 15, i32 142, i32 101, i32 131, i32 53, i32 56,
	i32 117, i32 87, i32 63, i32 0, i32 105, i32 115, i32 61, i32 15,
	i32 87, i32 77, i32 103, i32 119, i32 80, i32 124, i32 122, i32 51,
	i32 51, i32 135, i32 139, i32 100, i32 28, i32 20, i32 23, i32 58,
	i32 34, i32 136, i32 94, i32 95, i32 32, i32 119, i32 85, i32 53,
	i32 107, i32 123, i32 91, i32 74, i32 128, i32 63, i32 122, i32 41,
	i32 14, i32 40, i32 77, i32 84, i32 85, i32 38, i32 42, i32 39,
	i32 99, i32 30, i32 125, i32 30, i32 115, i32 41, i32 133, i32 59,
	i32 32, i32 142, i32 11, i32 62, i32 67, i32 64, i32 57, i32 129,
	i32 123, i32 119, i32 13, i32 21, i32 54, i32 12, i32 7, i32 132,
	i32 148, i32 110, i32 116, i32 81, i32 46, i32 66, i32 64, i32 49,
	i32 61, i32 6, i32 47, i32 111, i32 19, i32 88, i32 143, i32 125,
	i32 113, i32 67, i32 4, i32 120, i32 31, i32 52, i32 29, i32 35,
	i32 127, i32 83, i32 139, i32 10, i32 43, i32 0, i32 137, i32 117,
	i32 131, i32 80, i32 71, i32 135, i32 72, i32 73, i32 28
], align 16

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 u0x0000000000000000, ; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

; Functions

; Function attributes: memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 16

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/9.0.1xx @ 1dcfb6f8779c33b6f768c996495cb90ecd729329"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
