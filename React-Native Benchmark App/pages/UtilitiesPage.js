import React, { Component } from 'react';
import RNLocation from 'react-native-location'
import { View, Button, Text } from 'react-native';
import CryptoES from 'crypto-es';

export default class UtilitiesPage extends Component {

    state = {
        lat: 0.0,
        lon: 0.0,
        accuracy: 0.0,
        gpsExecTime: 0.0,
        jsonExecTime: 0.0,
        cryptoExecTime: 0.0
    }

    getJSON() {
        let start;
        let done;
        fetch('https://raw.githubusercontent.com/naabvb/TIES502-thesis-benchmarks/master/Assets/10mb-sample.json').then((response) => {
            start = performance.now();
            response.json().then(() => {
                done = performance.now();
                this.setState({
                    jsonExecTime: `${Math.round(done - start)} ms`
                })
            })
        })
    }

    getLocation() {
        RNLocation.requestPermission({
            ios: 'whenInUse', // or 'always'
            android: {
                detail: 'fine', // or 'fine'
            }
        });
        RNLocation.configure({ desiredAccuracy: { android: 'balancedPowerAccuracy', ios: 'best' }, androidProvider: 'playServices' });
        var start = performance.now();
        RNLocation.getLatestLocation({ timeout: 60000 })
            .then(latestLocation => {
                var done = performance.now()
                this.setState({
                    lat: latestLocation.latitude, lon: latestLocation.longitude, accuracy: latestLocation.accuracy, gpsExecTime: `${Math.round(done - start)} ms`
                })
            })
    }

    cryptoMark() {
        var start = performance.now();
        for (let i = 0; i < 800000; i++) {
            this.createHMAC(i)
        }
        var done = performance.now();
        this.setState({
            cryptoExecTime: `${Math.round(done - start)} ms`
        })
    }

    createHMAC(index) {
        var key = 'test-key';
        var bytes = 'verysecretteststring' + index;
        return CryptoES.HmacSHA256(bytes, key);
    }

    render() {
        const location = this.state.lon != 0 > 0 ? <View><Text>{this.state.lat + ', ' + this.state.lon}</Text><Text>{'Accuracy: ' + this.state.accuracy}</Text><Text>{this.state.gpsExecTime}</Text></View> : null;
        const jsonTime = this.state.jsonExecTime != 0 ? <Text>{this.state.jsonExecTime}</Text> : null;
        const cryptoTime = this.state.cryptoExecTime != 0 ? <Text>{this.state.cryptoExecTime}</Text> : null;
        return (
            <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
                <View style={{ marginBottom: 10 }}>
                    <Button title='GPS benchmark' onPress={() => this.getLocation()}></Button>
                    {location}
                </View>
                <View style={{ marginBottom: 10 }}>
                    <Button title='Run Crypto benchmark' onPress={() => this.cryptoMark()}></Button>
                    <View style={{ alignItems: 'center', justifyContent: 'center' }}>
                        {cryptoTime}
                    </View>
                </View>
                <Button title='Run JSON benchmark' onPress={() => this.getJSON()}></Button>
                {jsonTime}
            </View>)
    }
}