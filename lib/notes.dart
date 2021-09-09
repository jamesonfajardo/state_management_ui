// Onboarding
//  • Provider  - onboarding new developers is easy because provider is easy to understand
//  • Bloc      - onboarding new developers is challenging because of the confusing terms and concepts
//  • GetX      - onboarding new developers is fairly easy because getx is easier to understand than bloc

// Ease of use
//  • Provider  - easy to use, you only need to know 4 concepts: model, implementation, listen state, update state
//  • Bloc      - challenging to use because of confusing concepts and terms (Cubit, .emit, Bloc<event, dataType>, etc..) + Bloc specific syntax
//  • GetX      - easy to use but you need to remember the syntac specific to GetX.

// Flexibility
//  • Provider  - flexible because the data that you will be working on is raw data so you can easily use it for conditional statements
//  • Bloc      - not flexible because the data/state is bound to a widget, applying conditional statement is possible but at the cost of bloating the BlocBuilder widget
//  • GetX      - not flexible because the data/state is bound to a widget, applying conditional statement is possible but at the cost of bloating the widget

// Utilities
//  • Provider  - purely state management
//  • Bloc      - purely state management
//  • GetX      - GetX package includes utilities like validator, snackbar, dialogs which is a waste if won't be used

// Model
//  • Provider  - 1 model can hold multiple data/state
//  • Bloc      - 1 model can only hold 1 data/state
//  • GetX      - 1 model can hold multiple data/state

// Developer Friendly
//  • Provider  - you only need to familiarize with 4 syntax to use provider
//  • Bloc      - need to familiarize with syntax specific to Bloc
//  • GetX      - need to familiarize with syntax specific to GetX

// Setting State
//  • Provider  - needs to invoke notifyListeners() to update state
//  • Bloc      - needs to call the .emit(newValue) method to update state
//  • GetX      - directly assign a new value to model property, no methods need to invoke.  onChanged(newValue) => model.property.value = newValue;

// ! ====================== Implementation ======================

//* Provider



//* ======================
//* Step 1: create a model
//* ======================
import 'package:flutter/cupertino.dart';
// cupertino is important because it houses ChangeNotifier

// provider 1
class ProviderData extends ChangeNotifier {
  String string = 'Provider 1 Data'; // the app state/data

  void updateString(String updatedString) {
    string = updatedString;
    notifyListeners(); // this will trigger a rebuild like setState
  }
}

// provider 2
class ProviderData2 extends ChangeNotifier {
  String string = 'Provider 2 Data'; // the app state/data

  void updateString(String updatedString) {
    string = updatedString;
    notifyListeners(); // this will trigger a rebuild like setState
  }
}



//* =====================================
//* Step 2: set the provider in main.dart
//* =====================================
void main() => runApp(ProviderApp());

class ProviderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // always use multiprovider for additional model
    return MultiProvider(
      // providers - here you will define the different providers
      providers: [
        // provider 1
        ChangeNotifierProvider<ProviderData>(
          create: (context) => ProviderData(),
        ),
        // provider 2
        ChangeNotifierProvider<ProviderData2>(
          create: (context) => ProviderData2(),
        ),
        // provider 3 and so on..
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => Home(),
          '/page-1': (context) => Page1(),
          '/page-2': (context) => Page2(),
          '/page-3': (context) => Page3(),
        },
        initialRoute: '/',
      ),
    );
  }
}



//* =============================================
//* Step 3: listen to provider data value updates
//* =============================================
// provider 1
Text(Provider.of<ProviderData>(context).string),
// provider 2
Text(Provider.of<ProviderData2>(context).string),



//* ===================================================================
//* Step 4: event emitter to update provider data value
//* event emitters or conditional statements must include listen: false
//* ===================================================================
TextField(
  onChanged: (newValue) {
    // provider 1
    Provider.of<ProviderData>(context, listen: false).updateString(newValue);
    // provider 2
    Provider.of<ProviderData2>(context, listen: false).updateString(newValue);
  },
);



// ! ============================================


//* Bloc



//* ======================
//* Step 1: create a model
//* ======================

// model 1
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocData extends Cubit<String> {
  BlocData() : super('Bloc 1 Data');
}

// model 2
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocData2 extends Cubit<String> {
  BlocData2() : super('Bloc 2 Data');
}



//* =================================
//* Step 2: set the bloc in main.dart
//* =================================

void main() => runApp(BlocDemo());

class BlocDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // model 1
        BlocProvider(create: (context) => BlocData()),
        // model 2
        BlocProvider(create: (context) => BlocData2()),
        // model 3, and so on..
      ],
      child: MaterialApp(
        routes: {
          '/page-1': (context) => Page1(),
          '/page-2': (context) => Page2(),
          '/page-3': (context) => Page3(),
        },
        initialRoute: '/page-1',
      ),
    );
  }
}



//* ==============================
//* Step 3: listening to bloc data
//* ==============================

// model 1
BlocBuilder<BlocData, String>(builder: (context, state) {
  return Text('$state');
})
// model 2
BlocBuilder<BlocData2, String>(builder: (context, state) {
  return Text('$state');
})



//* ==========================
//* Step 4: updating bloc data
//* ==========================

// .emit(newValue) - is the one responsible for updating the data

child: TextField(
  onChanged: (newValue) {
    // model 1
    BlocProvider.of<BlocData>(context).emit(newValue);
    // model 2
    BlocProvider.of<BlocData2>(context).emit(newValue);
  },
),



// ! ============================================



// GetX



//* ======================
//* Step 1: create a model
//* ======================

import 'package:get/get.dart';

class Getx1 extends GetxController {
  var string = 'GetX 1 Data'.obs; // use var
}


Widget build(BuildContext context) {
  // always use .put() at the top most level of the widget tree
  // so the widgets under it can access the model instance via .find

  // only define .put or .find, do not define both on the same page

  // .put - used for initializing the model instance.
  // having multiple .put means multiple instance of the same model
  Getx1 getx1 = Get.put(Getx1()); 

  // .find - for reusing the initialized model anywhere down the widget tree
  // this won't create a new instance but reuse the instance from .put
  Getx1 getx1 = Get.find<Getx1>(); 

  return Scaffold(
    // and so on..
  );
}


//* =================================
//* Step 2: set getx in main.dart
//* =================================

void main() => runApp(StateManagementDemo());

class StateManagementDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // this
      routes: {
        '/page1': (context) => Page1(),
        '/page2': (context) => Page2(),
        '/page3': (context) => Page3(),
      },
      initialRoute: '/page1',
    );
  }
}



//* ==============================
//* Step 3: listening to GetX data
//* ==============================

// Getx1 getx1 = Get.put(Getx1());  // define the model via .put or .find
Getx1 getx1 = Get.find<Getx1>();    // define the model via .put or .find

Obx(() => Text('${getx1.string}')),



//* ==========================
//* Step 4: updating GetX data
//* ==========================

// Getx1 getx1 = Get.put(Getx1());  // define the model via .put or .find
Getx1 getx1 = Get.find<Getx1>();    // define the model via .put or .find

child: TextField(
  onChanged: (newValue) {
    getx1.string.value = newValue; // change the property value directly, no need to invoke any methods
  },
),


// Additional GetX Syntax

// Get.toNamed('/page2');   // navigator.pushNamed
// Get.back();              // navigator.pop