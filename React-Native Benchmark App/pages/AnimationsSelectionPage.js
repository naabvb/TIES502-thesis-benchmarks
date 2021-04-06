import React, {Component} from 'react';
import {View, Button} from 'react-native';

export default class AnimationsSelectionPage extends Component {
  render() {
    return (
      <View style={{flex: 1, alignItems: 'center', justifyContent: 'center'}}>
        <View style={{marginBottom: 10}}>
          <Button
            title="Low intensity"
            onPress={() =>
              this.props.navigation.navigate('animation', {columns: 4})
            }
            style={{padding: 30}}
          />
        </View>
        <View style={{marginBottom: 10}}>
          <Button
            title="Medium intensity"
            onPress={() =>
              this.props.navigation.navigate('animation', {columns: 8})
            }
            style={{padding: 30}}
          />
        </View>
        <View style={{marginBottom: 10}}>
          <Button
            title="High intensity"
            onPress={() =>
              this.props.navigation.navigate('animation', {columns: 16})
            }
            style={{padding: 30}}
          />
        </View>
      </View>
    );
  }
}
