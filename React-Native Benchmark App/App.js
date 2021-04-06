/**
 * React-Native benchmark app
 * Lauri Pimiä
 * @format
 * @flow strict-local
 */

import {NavigationContainer} from '@react-navigation/native';
import React from 'react';
import {View, Button} from 'react-native';
import AnimationsPage from './pages/AnimationsPage';
import {createStackNavigator} from '@react-navigation/stack';
import UtilitiesPage from './pages/UtilitiesPage';
import AnimationsSelectionPage from './pages/AnimationsSelectionPage';

function HomeScreen({navigation}) {
  return (
    <View style={{flex: 1, alignItems: 'center', justifyContent: 'center'}}>
      <View style={{marginBottom: 10}}>
        <Button
          title="Animations benchmarks"
          onPress={() => navigation.navigate('animationsselection')}
          style={{padding: 30}}
        />
      </View>
      <View>
        <Button
          title="Utilities benchmarks"
          onPress={() => navigation.navigate('utilities')}
        />
      </View>
    </View>
  );
}

const Stack = createStackNavigator();

const App = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="React-Native bench">
        <Stack.Screen
          name="home"
          component={HomeScreen}
          options={{title: 'React-Native Bench'}}
        />
        <Stack.Screen
          name="animation"
          component={AnimationsPage}
          options={{headerShown: false}}
        />
        <Stack.Screen
          name="animationsselection"
          component={AnimationsSelectionPage}
          options={{title: 'React-Native Bench'}}
        />
        <Stack.Screen
          name="utilities"
          component={UtilitiesPage}
          options={{title: 'React-Native Bench'}}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default App;
