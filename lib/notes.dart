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

FractionallySizedBox(
  child: TextField(
    onChanged: (newValue) {
      // model 1
      BlocProvider.of<BlocData>(context).emit(newValue);
      // model 2
      BlocProvider.of<BlocData2>(context).emit(newValue);
    },
  ),
)



// ! ============================================



// GetX