import React, {Component} from 'react';
import {Animated, Easing, View} from 'react-native';
import testikuva from '../assets/testikuva.jpg';

export default class SpinnerImage extends Component {
  spinValue = new Animated.Value(0);

  anim = Animated.loop(
    Animated.timing(this.spinValue, {
      toValue: 1,
      duration: 500,
      easing: Easing.linear,
      useNativeDriver: true,
    }),
  );

  componentDidUpdate() {
    if (this.props.spin === true) this.anim.start();
    if (this.props.spin === false) this.spinValue.setValue(0);
  }

  render() {
    const spin = this.spinValue.interpolate({
      inputRange: [0, 1],
      outputRange: ['0deg', '360deg'],
    });
    const spin2 = this.spinValue.interpolate({
      inputRange: [0, 1],
      outputRange: ['360deg', '0deg'],
    });
    var images = [];
    for (let i = 0; i < this.props.columns; i++) {
      images.push(
        <Animated.Image
          key={i}
          style={{
            transform: [{rotate: i % 2 == 0 ? spin : spin2}],
            width: 20,
            height: 10,
          }}
          source={testikuva}
        />,
      );
    }

    return (
      <View
        style={{
          alignItems: 'center',
          flexDirection: 'row',
          justifyContent: 'space-evenly',
          marginVertical: 9,
        }}>
        {images}
      </View>
    );
  }
}
