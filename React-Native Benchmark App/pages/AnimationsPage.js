import React, {Component} from 'react';
import {View, Button} from 'react-native';
import SpinnerImage from '../components/SpinnerImage';

export default class AnimationsPage extends Component {
  state = {
    spinning: false,
  };

  setSpin() {
    this.setState({spinning: this.state.spinning ? false : true});
  }

  render() {
    var rows = [];
    for (let i = 0; i < 13; i++) {
      rows.push(
        <SpinnerImage
          columns={this.props.route.params.columns}
          spin={this.state.spinning}
          key={i}></SpinnerImage>,
      );
    }

    return (
      <View>
        <View
          style={{
            flexDirection: 'column',
            justifyContent: 'space-evenly',
            marginBottom: 5,
          }}>
          {rows}
          <Button
            onPress={() => this.setSpin()}
            title={this.state.spinning ? 'Stop' : 'Start'}></Button>
        </View>
      </View>
    );
  }
}
